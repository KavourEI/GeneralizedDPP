import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalized_dpp/pages/LoggedOut/singin_page.dart';
import 'package:lottie/lottie.dart';

class AccountcreatedPage extends StatelessWidget{
  const AccountcreatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Center(child: Lottie.asset('assets/lottieFiles/account_created.json')),
        
              const SizedBox(height: 30,),
        
              ElevatedButton(
                onPressed: () {
                Navigator.pushReplacement(
                  context, 
                  CupertinoPageRoute(
                    builder: (context)=> LogInPage()
                    )
                  );
                }, 
                child: Text('To log in page'))
        
            ],
          ),
        ),
    );
  }
}