import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:generalized_dpp/pages/NotUsed/items_page_graphDB.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override 
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String dropdownvalue = 'English';
  final List<String> items = ['English', 'Greek', 'Spanish', 'French', 'German'];

  String? firstName;
  bool isLoading=true;
  int? countDocs = 0;
  int? nrOfUser = 0;
  List<Map<String, dynamic>> topItems = [];

  @override
  void initState() {
    super.initState();
    fetchUserFirstName();
    fetchCountDocuments();
    fetchUsers();
    laodTopItems();
  }

  Future<void> fetchUserFirstName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          firstName = null;
          isLoading = false;
        });
        return;
      }

      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      

      if (userDoc.exists) {
        final data = userDoc.data();
        setState(() {
          firstName = data?['firstName'] ?? 'User';
          isLoading = false;
        });
      } else {
        setState(() {
          firstName = 'User';
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching first name: $e');
      setState(() {
        firstName = 'User';
        isLoading = false;
      });
    }
  }

  Future<void> fetchCountDocuments() async {
    try {
      final aggregateQuerySnapshot = await FirebaseFirestore.instance.collection('alumil_dummy').count().get();
      setState(() {
        countDocs = aggregateQuerySnapshot.count;
      });
    } catch (e) {
      print('Error fetching documents: $e');
    }
  }

  Future<void> fetchUsers() async {
    try{
      final usersInDB = await FirebaseFirestore.instance.collection('users').count().get();
      setState(() {
        nrOfUser = usersInDB.count;
      });
    } catch (e) {
      print('Error fetching number of User: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchTopViewedDocuments() async{
    final numOfDocsOrdered = await FirebaseFirestore.instance.collection('alumil_dummy').orderBy('views', descending: true).limit(10).get();

    return numOfDocsOrdered.docs.map((doc) {
      final docsData = doc.data();
      return {
        'profile_code': docsData['profile_code'] ?? 'Unknown',
        'views': docsData['views'] ?? 0,
      };
    }).toList();
  }

  Future<void> laodTopItems() async {
    final items = await fetchTopViewedDocuments();
    setState(() {
      topItems = items;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(25),
              child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton(
                          value: dropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        Icon(Icons.notifications_none_outlined),
                      ],
                    ),

                    SizedBox(height: 30),

                    // Replace hardcoded text with fetched firstName (or loading/fallback)
                    isLoading
                        ? CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.tertiary,
                          )
                        : Text(
                            'Hello ${firstName ?? 'User'}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),

                    SizedBox(height: 10),

                    Text(
                      'Welcome to your virtual assistant',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25),

            // Text('Welcome Message'), // TODO: Make a pop-up with don't show again button to explain each page.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Your items',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.tertiary,),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Total Categories
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(25),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Column(
                          children: [
                            Text(
                              'Total Categories',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiaryFixedDim,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            Text(
                              '3',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 30),

                  //Total Items
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(25),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Column(
                          children: [
                            Text(
                              'Total Items',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiaryFixedDim,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            Text(
                              '$countDocs',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Last Month's Activity",
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.tertiary,),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  // Last month Activity (Item Changes)
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(25),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Column(
                          children: [
                            Text(
                              'Items changed',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiaryFixedDim,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            Text(
                              '32',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 30),

                  // Last month Activity (Users logged in)
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(25),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Column(
                          children: [
                            Text(
                              'Users Logged',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiaryFixedDim,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            Text(
                              '$nrOfUser',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

             SizedBox(height: 25),

            // Text('Welcome Message'), // TODO: Make a pop-up with don't show again button to explain each page.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Most Viewd Items',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(25),
                child: Container(
                  padding: EdgeInsets.all(15),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Column(
                    children: [

                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          MyTableRowHeader.build(context, 'Item name', 'Interactions'),
                          ...topItems.map(
                            (item) => 
                            MyTableRow.build(context, item['profile_code'], item['views'].toString()
                          )
                          ).toList(),
                        ],
                      )
  
                      // Table(
                      //   defaultVerticalAlignment:
                      //       TableCellVerticalAlignment.middle,
                      //   children: [
                      //     MyTableRowHeader.build(context, 'Item Name', 'Interactions',),
                      //     MyTableRow.build(context, 'Product Name 1', '70'),
                      //     MyTableRow.build(context, 'Product Name 2', '67'),
                      //     MyTableRow.build(context, 'Product Name 3', '53'),
                      //     MyTableRow.build(context, 'Product Name 4', '42'),
                      //     MyTableRow.build(context, 'Product Name 5', '28'),
                      //     MyTableRow.build(context, 'Product Name 6', '28'),
                      //     MyTableRow.build(context, 'Product Name 7', '16'),
                      //     MyTableRow.build(context, 'Product Name 8', '10'),
                      //     MyTableRow.build(context, 'Product Name 9', '8'),
                      //     MyTableRow.build(context, 'Product Name 10', '5'),
                      //     MyTableRow.build(context, 'Product Name 11', '5'),
                      //     MyTableRow.build(context, 'Product Name 12', '2'),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),

            // SizedBox(height: 20),

            // Text(
            //   'Buttons',
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            // ),

            // SizedBox(height: 10),

            // Text('View All items'),
            // Text('Settings'),
            // Text('Profile'),
            // Text('Log out'),
            // Text('Search Bar (optional)'),
            // Text('Notifications Icon'),
            // Text('Add new item'),
          ],
        ),
      ),
    );
  }
}

class MyTableRow {
  MyTableRow({required String name, required String visits});

  static TableRow build(BuildContext context, String name, String visits) {
    return TableRow(
      children: [
        Center(child: Text(
          name,
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
          ),)),
        Center(child: Text(
          visits, 
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
          ),)),
      ],
    );
  }
}

class MyTableRowHeader {
  MyTableRowHeader({required String name, required String visits});

  static TableRow build(BuildContext context, String name, String visits) {
    return TableRow(
      children: [
        Center(
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
        Center(
          child: Text(
            visits,
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 18,
              color: Theme.of(context).colorScheme.tertiary,
              ),
          ),
        ),
      ],
    );
  }
}
