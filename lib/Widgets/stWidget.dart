import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final String label_text;

  const SquareTile({
    super.key,
    required this.imagePath,
    required this.label_text
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ?? Colors.blue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 40,
            width: 50,
          ),
          SizedBox(width: 10,),
          Text(
            label_text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold
            )),
          
        ],
      ),
    );
  }
}