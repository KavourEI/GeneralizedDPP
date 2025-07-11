import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<dynamic, dynamic> product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    final keys = product.keys.toList();

    return Scaffold(
      appBar: AppBar(title: Text(product['Product Name'] ?? 'Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          border: TableBorder.all(),
          columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(3),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[300]),
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Field', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Value', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            ...keys.map((key) {
              return TableRow(children: [
                Padding(padding: EdgeInsets.all(8), child: Text(key.toString())),
                Padding(padding: EdgeInsets.all(8), child: Text(product[key].toString())),
              ]);
            }).toList(),
          ],
        ),
      ),
    );
  }
}
