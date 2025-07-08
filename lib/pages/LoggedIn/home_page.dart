import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String dropdownvalue = 'English';

  final List<String> items = ['English', 'Greek', 'Spanish', 'French', 'Geman'];
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surface,
      // appBar: AppBar(title: Text('Home Page')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(25),
              child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                color: Colors.blueGrey,
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
                              child: Text(items),
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

                    Text(
                      'Hello Themis',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text('Welcome to your virtual assistant'),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Text('Welcome Message'), // TODO: Make a pop-up with don't show again button to explain each page.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Your items',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

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
                        color: Colors.grey.shade600,
                        child: Column(
                          children: [
                            Text(
                              'Total Categories',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            Text(
                              '25',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
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
                        color: Colors.grey.shade600,
                        child: Column(
                          children: [
                            Text(
                              'Total Items',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            Text(
                              '125',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
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

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Last Month's Activity",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  // Last month Activity (Item Changes)
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(25),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        color: Colors.grey.shade600,
                        child: Column(
                          children: [
                            Text(
                              'Items changed',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            Text(
                              '4',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
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
                        color: Colors.grey.shade600,
                        child: Column(
                          children: [
                            Text(
                              'Users Logged',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            Text(
                              '79',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
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

             SizedBox(height: 20),

            // Text('Welcome Message'), // TODO: Make a pop-up with don't show again button to explain each page.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Most Viewd Items',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(25),
                child: Container(
                  padding: EdgeInsets.all(15),
                  color: Colors.grey.shade600,
                  child: Column(
                    children: [
  
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          MyTableRowHeader.build('Item Name', 'Interactions'),
                          MyTableRow.build('Name 1', '70'),
                          MyTableRow.build('Name 2', '67'),
                          MyTableRow.build('Name 3', '53'),
                          MyTableRow.build('Name 4', '42'),
                          MyTableRow.build('Name 5', '28'),
                          MyTableRow.build('Name 6', '28'),
                          MyTableRow.build('Name 7', '16'),
                          MyTableRow.build('Name 8', '10'),
                          MyTableRow.build('Name 9', '8'),
                        ],
                      ),
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

  static TableRow build(String name, String visits) {
    return TableRow(
      children: [
        Center(child: Text(name)),
        Center(child: Text(visits)),
      ],
    );
  }
}

class MyTableRowHeader {
  MyTableRowHeader({required String name, required String visits});

  static TableRow build(String name, String visits) {
    return TableRow(
      children: [
        Center(child: Text(name,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
        Center(child: Text(visits,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
      ],
    );
  }
}
