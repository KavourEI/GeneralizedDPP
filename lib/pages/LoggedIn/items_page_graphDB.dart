import 'package:flutter/material.dart';
import 'package:generalized_dpp/services/graphdb_service.dart';


class ItemsPage extends StatelessWidget {
  ItemsPage({super.key});
  final GraphDBService graphDBService = GraphDBService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text('Items Page')),
        body: FutureBuilder(
          future: graphDBService.getSampleData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final data = snapshot.data!['data']['results']['bindings'];
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  return ListTile(
                    title: Text(item['subject']['value']),
                    subtitle: Text('${item['predicate']['value']}: ${item['object']['value']}'),
                  );
                },
              );
            }
          },
        ),
    );
  }
}