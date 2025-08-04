import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalized_dpp/pages/LoggedIn/SettingsSections/supportDetailsPage.dart';
import 'package:generalized_dpp/pages/LoggedOut/langing_page.dart';
import 'package:local_auth/error_codes.dart';

class AccountDetailsSection extends StatefulWidget {
  const AccountDetailsSection({super.key});

  @override
  State<AccountDetailsSection> createState() => _AccountDetailsSectionState();
}

class _AccountDetailsSectionState extends State<AccountDetailsSection> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSurname = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerLocation = TextEditingController();
  final TextEditingController _controllerCountry = TextEditingController();

  // String textName = '';
  // String textSurname = '';
  // String textUsername = '';
  // String textEmail = '';
  // String textPhoneNumber = '';
  // String textLocation = '';

  bool _isloading = true;
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState(){
    super.initState();
    _fetchUserData();

    // _controllerName.addListener(() {
    //   final String text = _controllerName.text;
    // });

    // _controllerSurname.addListener(() {
    //   final String text = _controllerSurname.text;
    // });

    // _controllerUsername.addListener(() {
    //   final String text = _controllerUsername.text;
    // });

    // _controllerEmail.addListener(() {
    //   final String text = _controllerEmail.text;
    // });

    // _controllerPhoneNumber.addListener(() {
    //   final String text = _controllerPhoneNumber.text;
    // });

    // _controllerLocation.addListener(() {
    //   final String text = _controllerLocation.text;
    // });
  }

  Future<void> _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users').
        doc(user.uid)
        .get();

      setState(() {
        if (userDoc.exists) {
          final data = userDoc.data() as Map<String, dynamic>? ?? {};
          _controllerName.text = data['firstName'] ?? '';
          _controllerSurname.text = data['lastName'] ?? '';
          _controllerUsername.text = data['userName'] ?? '';
          _controllerEmail.text = data['email'] ?? '';
          _controllerPhoneNumber.text = data['phone'] ?? '';
          _controllerLocation.text = data['locationName'] ?? '';
          _controllerCountry.text = data['country'] ?? '';
        } else {
          _controllerEmail.text = user.email ?? '';
        }
        _isloading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load user data';
        _isloading = false;
      });
    }
  }

  Future<void> _saveUserData() async {
    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not logged in');

      await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({
        'firstName': _controllerName.text,
        'lastName': _controllerSurname.text,
        'userName': _controllerUsername.text,
        'email': _controllerEmail.text,
        'phone': _controllerPhoneNumber.text,
        'locationName': _controllerLocation.text,
        'country': _controllerCountry.text,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));  //Is this going to add them at the bottom or replace?

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile update succesfully')),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to update profile: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }
  

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerSurname.dispose();
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPhoneNumber.dispose();
    _controllerLocation.dispose();
    _controllerCountry.dispose();
    super.dispose();
  }


  Widget _buildSectionDevider(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const Expanded(child: Divider(thickness: 1)),
      ],
    );
  }

  Widget _buildSettingItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _myTextField(String labeltext, TextEditingController controller) {
    return TextField(
      controller : controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labeltext,
      ),
    );
  }

  Future<void> reauthenticateUser(String email, String password) async {
    User user = FirebaseAuth.instance.currentUser!;
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await user.reauthenticateWithCredential(credential);
  }

  Future<void> deleteUserData(String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
  }

  Future<void> deleteUserAccount() async {
    User user = FirebaseAuth.instance.currentUser!;
    await user.delete();
  }

  Future<bool> deleteUserAndData(String email, String password) async {
    try {
      await reauthenticateUser(email, password);

      String uid = FirebaseAuth.instance.currentUser!.uid;
      await deleteUserData(uid);

      await deleteUserAccount();
      return true;
    } catch (e) {
      print('Error deleting user and data: $e');
      return false;
    }
  }

  Future<String?> _askUserPassword(BuildContext context) async {
    TextEditingController passwordController = TextEditingController();

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please enter your password to confirm.'),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                autofocus: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null), // cancel
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (passwordController.text.isNotEmpty) {
                  Navigator.of(context).pop(passwordController.text);
                }
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(25),
              child: Container(
                padding: EdgeInsets.all(35),
                width: double.infinity,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  children: [
                    _buildSectionDevider("Profile Info"),

                    _buildSettingItem('Name'),
                    _myTextField(
                      'Name', 
                      _controllerName),

                    const SizedBox(height: 10),
                    _buildSettingItem('Surname'),
                    _myTextField(
                      'Surname',
                      _controllerSurname),

                    const SizedBox(height: 10),
                    _buildSettingItem('Username'),
                    _myTextField(
                      'Username',
                      _controllerUsername),

                    const SizedBox(height: 10),
                    _buildSettingItem('Email'),
                    _myTextField(
                      'Email',
                      _controllerEmail),

                    const SizedBox(height: 10),
                    _buildSettingItem('Phone Number'),
                    _myTextField(
                      'Phone Number',
                      _controllerPhoneNumber),

                    const SizedBox(height: 10),
                    _buildSettingItem('Location'),
                    _myTextField(
                      'Location',
                      _controllerLocation),

                    const SizedBox(height: 10),
                    _buildSettingItem('Country'),
                    _myTextField(
                      'Country',
                      _controllerCountry),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(25),
              child: Container(
                padding: EdgeInsets.all(35),
                width: double.infinity,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  children: [
                    _buildSectionDevider("Password & Security"),
                    

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSettingItem('2-Factor Authentication (2FA)'),
                        CupertinoSwitch(
                          activeTrackColor: Colors.blue.shade100,
                          thumbColor: Colors.black,
                          // when the switch is off
                          inactiveTrackColor: Colors.black12,
                          // boolean variable value
                          value: true,
                          // changes the state of the switch
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(25),
              child: Container(
                padding: EdgeInsets.all(35),
                width: double.infinity,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  children: [
                    _buildSectionDevider("Login Methods"),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSettingItem('Email/Password'),
                        CupertinoSwitch(
                          activeTrackColor: Colors.blue.shade100,
                          thumbColor: Colors.black,
                          inactiveTrackColor: Colors.black12,
                          value: true,
                          onChanged: (value) {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSettingItem('Google Account'),
                        CupertinoSwitch(
                          activeTrackColor: Colors.blue.shade100,
                          thumbColor: Colors.black,
                          inactiveTrackColor: Colors.black12,
                          value: true,
                          onChanged: (value) {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSettingItem('Apple Account'),
                        CupertinoSwitch(
                          activeTrackColor: Colors.blue.shade100,
                          thumbColor: Colors.black,
                          inactiveTrackColor: Colors.black12,
                          value: true,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Delete my account'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                ),
                onPressed: () async {
                  String email = FirebaseAuth.instance.currentUser!.email!;

                  // Ask for password input
                  String? password = await _askUserPassword(context);

                  if (password == null || password.isEmpty) {
                    // User cancelled or did not enter password
                    print('Password was not provided.');
                    return;
                  }

                  bool success = await deleteUserAndData(email, password);

                  if (!success) {
                    // Show error to user
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Failed to delete account. Please check your password and try again.',
                        ),
                      ),
                    );
                    return;
                  }

                  // On success, navigate away (e.g., to a landing page)
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(builder: (context) => LandingPage()),
                  );
                },
              ),
            ),

            SizedBox(height: 20,),

            SizedBox(
               width: double.infinity,
               child: ElevatedButton(
                onPressed: _isSaving ? null : _saveUserData, 
                child: _isSaving
                  ? const CircularProgressIndicator()
                  : const Text('Save Changes'),
               )
            ),
          ],
        ),
      ),
    );
  }
}