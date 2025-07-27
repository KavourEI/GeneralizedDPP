import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalized_dpp/Widgets/signOptionsWidget.dart';
import 'package:generalized_dpp/pages/LoggedOut/about_page.dart';
import 'package:generalized_dpp/pages/LoggedOut/langing_page.dart';
import 'package:generalized_dpp/pages/LoggedOut/register.dart';
import 'package:generalized_dpp/pages/widget_tree.dart';
import 'package:lottie/lottie.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LogInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateUsernameOrEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username or email';
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

  Future<String?> _getEmailFromUsernameOrEmail(String userInput) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');

    final usernameResult = await usersCollection
        .where('userName', isEqualTo: userInput)
        .limit(1)
        .get();

    if (usernameResult.docs.isNotEmpty) {
      final email = usernameResult.docs.first.data()['email'] as String?;
      if (email != null && email.isNotEmpty) {
        return email;
      }
    }

    final emailResult = await usersCollection
        .where('email', isEqualTo: userInput)
        .limit(1)
        .get();

    if (emailResult.docs.isNotEmpty) {
      final email = emailResult.docs.first.data()['email'] as String?;
      if (email != null && email.isNotEmpty) {
        return email;
      }
    }

    return null;
  }

  Future<void> signUserIn(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final userInput = _emailController.text.trim();
      final passwordInput = _passwordController.text.trim();

      try {
        final email = await _getEmailFromUsernameOrEmail(userInput);

        if (email == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User not found with that username or email.'),
            ),
          );
          return;
        }

        final UserCredential userCredential = await _auth
            .signInWithEmailAndPassword(email: email, password: passwordInput);

        if (userCredential.user != null) {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(builder: (context) => WidgetTree()),
          );
        }
      } on FirebaseAuthException catch (e) {
        log('Login failed: $e');
        String errorMessage = 'Login failed. Please check your credentials.';
        if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password.';
        } else if (e.code == 'user-not-found') {
          errorMessage = 'No user found with this email.';
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      } catch (e) {
        log('Login failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed. Please try again later.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: const Text('Home'),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const LandingPage(),
                          ),
                        );
                      },
                    ),
                    TextButton(
                      child: const Text('About Us'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const AboutPage(),
                          ),
                        );
                      },
                    ),
                    TextButton(
                      child: const Text('Log In'),
                      onPressed: () {
                        // Current page, no action
                      },
                    ),
                  ],
                ),
                const Divider(color: Colors.black, indent: 20, endIndent: 20),
                Container(
                  height: 350,
                  child: Lottie.asset('assets/lottieFiles/Products.json'),
                ),
                // *** Modified text field for username/email, changed label and validator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: _emailController,
                    cursorColor: const Color.fromRGBO(220, 150, 89, 1.0),
                    validator: _validateUsernameOrEmail,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      labelText: "Username or Email",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    cursorColor: const Color.fromRGBO(220, 150, 89, 1.0),
                    validator: _validatePassword,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      labelText: "Password",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),
                //Forgot Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const Placeholder(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password →",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    onPressed: () => signUserIn(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: ContinueWith(
                        onPressed: () {},
                        imagePath: 'assets/logos/google.png',
                        label: 'Google',
                      ),
                    ),
                    Container(
                      child: ContinueWith(
                        onPressed: () {},
                        imagePath: 'assets/logos/apple.png',
                        label: 'Apple',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        " Register now!",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
