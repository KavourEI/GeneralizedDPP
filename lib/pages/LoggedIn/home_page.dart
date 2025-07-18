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

                    Text(
                      'Hello Themis',
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
                      ),),

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
                              '25',
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
                              '125',
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
                              '4',
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
                              '79',
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
                          MyTableRowHeader.build(context, 'Item Name', 'Interactions',),
                          MyTableRow.build(context, 'Product Name 1', '70'),
                          MyTableRow.build(context, 'Product Name 2', '67'),
                          MyTableRow.build(context, 'Product Name 3', '53'),
                          MyTableRow.build(context, 'Product Name 4', '42'),
                          MyTableRow.build(context, 'Product Name 5', '28'),
                          MyTableRow.build(context, 'Product Name 6', '28'),
                          MyTableRow.build(context, 'Product Name 7', '16'),
                          MyTableRow.build(context, 'Product Name 8', '10'),
                          MyTableRow.build(context, 'Product Name 9', '8'),
                          MyTableRow.build(context, 'Product Name 10', '5'),
                          MyTableRow.build(context, 'Product Name 11', '5'),
                          MyTableRow.build(context, 'Product Name 12', '2'),
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
