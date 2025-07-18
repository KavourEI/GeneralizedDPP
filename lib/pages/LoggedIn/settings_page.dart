import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:generalized_dpp/services/database_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Settings Page'),
        automaticallyImplyLeading: false,),

      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(onPressed: () async {
                  await DatabaseService()
                    .create(path: 'data1', data: "{'Col1': 'Value1 😀'}");
                  
                }, child: Text('Create')),
                ),
                ],
              ),
        
          
          SizedBox(height: 20,),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(onPressed: () async {
                  DataSnapshot? snapshot=
                  await DatabaseService()
                    .read(path: 'data1');
                    print(snapshot?.value);
                  
                }, child: Text('Read')),
              ),
            ],
          ),

          SizedBox(height: 20,),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(onPressed: () async {
                  await DatabaseService()
                    .update(path: 'data3', data: {'name': 'Flutter Pro'});
                }, child: Text('Update')),
              ),
            ],
          ),
          
          SizedBox(height: 20,),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(onPressed: () async {
                  await DatabaseService()
                  .delete(path: 'data3');
                   
                }, child: Text('Delete')),
              ),
            ],
          ),
        ],
      ),
      );
  }
}