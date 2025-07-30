import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? firstname;
  String? lastname;
  late Timestamp regDate;
  late DateTime myDateTime;
  String? formattedDate;
  String? birthDate;
  String? email;

  bool isLoading=true;
  
  @override
  void initState(){
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user==null){
        setState(() {
          firstname = null;
          lastname = null;
          regDate = Timestamp(0, 0);
          birthDate = null;
          email = null;
          isLoading = false;
        });
      return;
    }

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    if (userDoc.exists){
      final data = userDoc.data();
      setState(() {
        firstname = data?['firstName'] ?? 'UserName1';
        lastname = data?['lastName'] ?? 'UserSurname2';
        regDate = data?['registrationDate'] ?? 'UserRegDate';
        myDateTime = regDate.toDate();
        formattedDate = DateFormat('dd/MM/yyyy').format(myDateTime);
        birthDate = data?['birthDate'] ?? 'No Birthdate';
        email = data?['email'] ?? 'No email';
        
        isLoading = false;
      });
    }
    } catch (e) {
    print('Error fetching full name $e');
    setState(() {
      firstname = 'UserName';
      lastname = 'UserSurname';
      regDate = Timestamp(0, 0);
      birthDate = 'No Birthdate';
      email = 'No email';
      isLoading = false;
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
          
              //first level of information
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(16),
                        child: Container(
                          width: double.infinity,
                          color: Theme.of(context).colorScheme.primaryContainer,
                          padding: EdgeInsets.all(25),
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              Text(
                                '$firstname' + ' $lastname',    //TODO: Need to change dynamically from the database 
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Member Since:' + ' $formattedDate',    //TODO: Need to change dynamically from the database 
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
          
                      Positioned(
                      top: -40,
                      left: 0,
                      right: 0,
                      child: ClipOval(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'assets/profile_pic/Unknown.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(25),
                child: Container(
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
        
                        // Section Title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
        
                        SizedBox(height: 15,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Column(
                              children: [
                                Text(
                                  'Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(25),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                                    color: Theme.of(context).colorScheme.surface,
                                    child: Text(
                                      '$firstname',
                                      style: TextStyle(
                                        fontSize: 18
                                      ),),
                                  ),
                                )
                              ],
                            ),

                            Column(
                              children: [
                                Text(
                                  'Surname',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(25),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                                    color: Theme.of(context).colorScheme.surface,
                                    child: Text(
                                      '$lastname',
                                      style: TextStyle(
                                        fontSize: 18
                                      ),),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 15,),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Column(
                              children: [
                                Text(
                                  'Current Location',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(25),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                                    color: Theme.of(context).colorScheme.surface,
                                    child: Text(
                                      'Athens',    //TODO: Need to add this information in database as well
                                      style: TextStyle(
                                        fontSize: 18
                                      ),),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 15,),

                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Column(
                              children: [
                                Text(
                                  'Date of Birth',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(25),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                                    color: Theme.of(context).colorScheme.surface,
                                    child: Text(
                                      '$birthDate',
                                      style: TextStyle(
                                        fontSize: 18
                                      ),),
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),

                        SizedBox(height: 15,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Column(
                              children: [
                                Text(
                                  'Email address',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(25),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                                    color: Theme.of(context).colorScheme.surface,
                                    child: Text(
                                      '$email',    // TODO: Make it dynamic to change the size if the email is too long, also do that for the rest of the text fields
                                      style: TextStyle(
                                        fontSize: 18
                                      ),),
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),

                        SizedBox(height: 10,),
        
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    )
    );
  }
}