import 'package:flutter/material.dart';
import 'package:generalized_dpp/Widgets/stWidget.dart';

class ContinueWithRow extends StatelessWidget {
  final String imagePath1;
  final String label1;
  final String imagePath2;
  final String label2;

  const ContinueWithRow({
    super.key,
    required this.imagePath1,
    required this.label1,
    required this.imagePath2,
    required this.label2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SquareTile(imagePath: imagePath1, label_text: label1),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SquareTile(imagePath: imagePath2, label_text: label2),
          ),
        ],
      ),
    );
  }
}

class ContinueWith extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback? onPressed;
  

  const ContinueWith({
    super.key,
    required this.imagePath,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Column(
            children: [
              Image.asset(imagePath, height: 40, width: 50),
              SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}