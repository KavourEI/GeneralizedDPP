import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:generalized_dpp/pages/LoggedOut/langing_page.dart';
import 'package:generalized_dpp/theme/theme.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Product Passport',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
      home: LandingPage()
    );
  }
}
