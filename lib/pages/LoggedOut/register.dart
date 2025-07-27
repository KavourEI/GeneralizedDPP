import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:generalized_dpp/Widgets/registrationTextFieldsWidget.dart';
import 'package:generalized_dpp/pages/LoggedOut/accountCreated_page.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dobController =
      TextEditingController(); //dob == date of birth

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> registerUser(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );

        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          await _firestore.collection('users').doc(uid).set({
            'userName': _usernameController.text.trim(),
            'firstName': _nameController.text.trim(),
            'lastName': _surnameController.text.trim(),
            'email': _emailController.text.trim(),
            'createdAt': DateTime.now().toIso8601String(),
            'birthDate': _dobController.text.trim(),
            'registrationDate': DateTime.now(),
          });

          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(builder: (context) => AccountcreatedPage()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registration failed. $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Center(
                  child: Opacity(
                    opacity: 0.5,
                    child: Lottie.asset(
                      'assets/lottieFiles/user_shielda_aimation.json',
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                    Center(
                        child: Text(
                          "Welcome! Let's create your account!",
                          style: TextStyle(color: Colors.grey[600],
                          fontSize: 18),),
                      ),
                
                      const SizedBox(height: 50,),
                
                      RTextFieldswidget(
                        controller: _usernameController,
                        validator: (value) => _validateNotEmpty(value, 'username'),
                        labelText: 'Username',
                        onTap: () {},
                      ),
                
                      RTextFieldswidget(
                        controller: _nameController,
                        validator: (value) => _validateNotEmpty(value, 'name'),
                        labelText: 'Name',
                        onTap: () {},
                      ),
                
                      RTextFieldswidget(
                        controller: _surnameController,
                        validator: (value) => _validateNotEmpty(value, 'surname'),
                        labelText: 'Surname',
                        onTap: () {},
                      ),

                      RTextFieldswidget(
                        controller: _dobController,
                        validator: (value) => value == null || value.isEmpty
                          ? 'Please enter yout date of birth'
                          : null,
                        labelText: 'Date of birth',
                        readOnly: true,
                        onTap: () {_selectDate(context);},
                      ),
                
                      RTextFieldswidget(
                        controller: _emailController,
                        validator: (value) => _validateNotEmpty(value, 'email'),
                        labelText: 'Email',
                        onTap: () {},
                      ),
                
                      RTextFieldswidget(
                        controller: _passwordController,
                        validator: (value) => _validateNotEmpty(value, 'password'),
                        labelText: 'Password',
                        onTap: () {},
                      ),
                      
                
                      ElevatedButton(
                        onPressed: () => registerUser(context),
                        child: Text('Register',)),
                        
                      const SizedBox(height: 20.0),
                
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already a member?", style: TextStyle(color: Colors.grey[700])),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                " Login now!",
                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                    ]
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
