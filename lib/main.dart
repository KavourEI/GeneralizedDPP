import 'package:flutter/material.dart';
import 'package:generalized_dpp/pages/widget_tree.dart';
import 'package:generalized_dpp/theme/theme.dart';

void main() {
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
      home: WidgetTree()
    );
  }
}
