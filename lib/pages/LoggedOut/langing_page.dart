import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalized_dpp/pages/LoggedOut/about_page.dart';
import 'package:generalized_dpp/pages/LoggedOut/sign_page.dart';

class LangingPage extends StatelessWidget{
  const LangingPage({super.key});

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
                  // Navigator.pushReplacement(
                  //   context,
                  //   CupertinoPageRoute(builder: (context) => const LangingPage())
                  // );
                },),
                TextButton(child: Text('About Us'),onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => const AboutPage())
                  );
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
                      Text("This is going to be a home page where there is a catchy text / images / animations to get the client's attention!"),
                      Text('\nNeed to carefully think about that and do not add a simple one liner text, it is going to be the first glance of somebody that opens the application'),
                      Text('\nCurrently it is work under process! The value needs to be great. Also there are other issues like functionalities that needs to be taken care first.')
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