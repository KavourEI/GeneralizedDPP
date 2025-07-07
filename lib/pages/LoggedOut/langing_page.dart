import 'package:flutter/material.dart';

class LangingPage extends StatelessWidget{
  const LangingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Landing Page'),
      ),
      
    );
  }
}