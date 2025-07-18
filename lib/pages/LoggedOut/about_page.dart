import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalized_dpp/pages/LoggedOut/langing_page.dart';
import 'package:generalized_dpp/pages/LoggedOut/sign_page.dart';

class AboutPage extends StatelessWidget{
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: SafeArea(
        child: Column(
          children: [
            //Top Navigation Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(child: Text('Home'),onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => const LangingPage())
                  );
                },),
                TextButton(child: Text('About Us'),onPressed: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   CupertinoPageRoute(builder: (context) => const AboutPage())
                  // );
                },),
                TextButton(child: Text('Log In'),onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => const LogInPage())
                  );
                },),
              ],
            ),

            Divider(
              color: Colors.black,
              indent: 20,
              endIndent: 20,
            ),

            SizedBox(height: 150,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(15),
                child: Container(
                  padding: EdgeInsets.all(15),
                  color: Colors.amber,
                  child: Column(
                    children: [
                      Text("This is going to be an about page where we are going to carefully present who we are and why we are the best!"),
                      Text("\nNothing more Nothing less! The answer to why you is only one, because I am the best, don't forther that!")
                    ],
                  ),
                ),
              ),
            )
            
          ],
        ),
      ),
      
    );
  }
}