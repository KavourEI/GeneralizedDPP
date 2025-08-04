import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => TestPageState();
}

class TestPageState extends State<TestPage>{
  final TextEditingController _controller = TextEditingController();
  String displayedText = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener((){
      final String text = _controller.text;
      if (_controller.text!= text) {
        _controller.value = _controller.value.copyWith(
          text: text,
          selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty
        );
      }
    });
  }

  @override 
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Input and Display'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter text here',
                hintText: 'Type something...',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // When the button is pressed, update the state variable
                // with the current text from the TextEditingController.
                setState(() {
                  displayedText = _controller.text;
                });
              },
              child: const Text('Display Entered Text'),
            ),
            const SizedBox(height: 24.0),
            // Display the text that was captured when the button was pressed
            Text(
              displayedText.isEmpty ? 'No text entered yet.' : 'Entered: "$displayedText"',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: displayedText.isEmpty ? Colors.grey : Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}




