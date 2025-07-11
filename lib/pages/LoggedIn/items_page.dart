import 'package:firebase_core/firebase_core.dart'; // Make sure Firebase is initialized in your app
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:generalized_dpp/services/product_detail_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final DatabaseReference _ref = FirebaseDatabase.instanceFor(
    app: Firebase.app(), // Assumes Firebase initialized already in main.dart
    databaseURL:
        'https://generalizeddpp-default-rtdb.europe-west1.firebasedatabase.app/',
  ).ref().child('products');

  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true; // track loading state

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
  try {
    final snapshot = await _ref.get();

    debugPrint('Snapshot exists? ${snapshot.exists}');
    debugPrint('Snapshot value: ${snapshot.value}');

    if (snapshot.exists) {
      final List<Map<String, dynamic>> tempList = [];

      for (final child in snapshot.children) {
        debugPrint('Child key: ${child.key}, value: ${child.value}');
        final value = child.value;

        if (value is Map<dynamic, dynamic>) {
          final mapped =
              value.map((key, val) => MapEntry(key.toString(), val));
          tempList.add(mapped);
        } else if (value is List<dynamic>) {
          // If the child is a List, iterate and add each item if it's a Map
          for (var item in value) {
            if (item is Map<dynamic, dynamic>) {
              final mapped =
                  item.map((key, val) => MapEntry(key.toString(), val));
              tempList.add(mapped);
            } else {
              debugPrint('Skipped list item: not a Map');
            }
          }
        } else {
          debugPrint("Skipped ${child.key}: not a Map or List");
        }
      }

      setState(() {
        _products = tempList;
        _isLoading = false;
      });
    } else {
      debugPrint("No data found at 'products'");
      setState(() {
        _products = [];
        _isLoading = false;
      });
    }
  } catch (e) {
    debugPrint('Error fetching products: $e');
    setState(() {
      _products = [];
      _isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _products.isEmpty
              ? const Center(child: Text('No products found.'))
              : ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(product: product),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(product['Product Name'] ?? 'No Name'),
                          subtitle: Text(
                              'Product Number: ${product['Product Number'] ?? 'N/A'}'),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
