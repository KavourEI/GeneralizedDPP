import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalized_dpp/pages/LoggedOut/langing_page.dart';
import 'package:local_auth/error_codes.dart';

class AccountDetailsSection extends StatefulWidget {
  const AccountDetailsSection({super.key});

  @override
  State<AccountDetailsSection> createState() => _AccountDetailsSectionState();
}

class _AccountDetailsSectionState extends State<AccountDetailsSection> {
  String? _selectedLanguage = 'English';
  String? _selectedTimeZone =
      'UTC+2 (Athens)'; // TODO: Set the default value to be the selected one when the user started using the app

  Widget _buildSectionDevider(String text) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(child: Divider(thickness: 1)),
      ],
    );
  }

  Widget _buildSettingItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _myTextField(String text) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: text,
      ),
    );
  }

  Widget _buildMembershipCarousel() {
    // TODO: Implement carousel of three cards for plans
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'Membership Plans Carousel (TODO)',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return DropdownButton<String>(
      value: _selectedLanguage,
      items: const [
        DropdownMenuItem(value: 'English', child: Text('English')),
        DropdownMenuItem(value: 'Greek', child: Text('Greek')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value;
        });
        print(value);
      },
      borderRadius: BorderRadius.circular(25),
      dropdownColor: Colors.blueGrey,
      isExpanded: true,
    );
  }

  Widget _buildTimeZoneDropdown() {
    return DropdownButton<String>(
      value: _selectedTimeZone,
      items: const [
        DropdownMenuItem(
          value: 'UTC+2 (Athens)',
          child: Text('UTC+2 (Athens)'),
        ),
        DropdownMenuItem(
          value: 'UTC+1 (London)',
          child: Text('UTC+1 (London)'),
        ),
        DropdownMenuItem(value: 'UTC (Lisbon)', child: Text('UTC (Lisbon)')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedTimeZone = value;
        });
      },
      borderRadius: BorderRadius.circular(25),
      dropdownColor: Colors.blueGrey,
      isExpanded: true,
    );
  }

  void _downloadBillingHistory() {
    print(
      'Downloading billing history...',
    ); // TODO: Create a page to see all the available history billing information and be downloadable to a pdf
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
            Center(
              child: const Text(
                'Account Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    _buildSectionDevider("Profile Info"),

                    _buildSettingItem('Name'),
                    _myTextField('John'),

                    const SizedBox(height: 10),
                    _buildSettingItem('Surname'),
                    _myTextField('Doe'),

                    const SizedBox(height: 10),
                    _buildSettingItem('Username'),
                    _myTextField('TheKrab'),

                    const SizedBox(height: 10),
                    _buildSettingItem('Email'),
                    _myTextField('themis.kavour@icloud.com'),

                    const SizedBox(height: 10),
                    _buildSettingItem('Phone Number'),
                    _myTextField('0123456789'),

                    const SizedBox(height: 10),
                    _buildSettingItem('Location'),
                    _myTextField('Athens, Greece'),
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

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSettingItem('Password'),
                        ElevatedButton(
                          onPressed: () => _downloadBillingHistory(),
                          child: const Text('Change Password'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSettingItem('2-Factor Authentication (2FA)'),
                        CupertinoSwitch(
                          // overrides the default green color of the track
                          activeTrackColor: Colors.green,
                          // color of the round icon, which moves from right to left
                          thumbColor: Colors.red,
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
                          // overrides the default green color of the track
                          activeTrackColor: Colors.green,
                          // color of the round icon, which moves from right to left
                          thumbColor: Colors.red,
                          // when the switch is off
                          inactiveTrackColor: Colors.black12,
                          // boolean variable value
                          value: true,
                          // changes the state of the switch
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
                          // overrides the default green color of the track
                          activeTrackColor: Colors.green,
                          // color of the round icon, which moves from right to left
                          thumbColor: Colors.red,
                          // when the switch is off
                          inactiveTrackColor: Colors.black12,
                          // boolean variable value
                          value: true,
                          // changes the state of the switch
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
                          // overrides the default green color of the track
                          activeTrackColor: Colors.green,
                          // color of the round icon, which moves from right to left
                          thumbColor: Colors.red,
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
          ],
        ),
      ),
    );
  }
}
