import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:generalized_dpp/pages/LoggedIn/product_detail_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('alumil_dummy');

  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true; // track loading state

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    try {
      final querySnapshot = await _collectionRef.get();

      if (querySnapshot.docs.isNotEmpty) {
        final tempList = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return data;
        }).toList();

        setState(() {
          _products = tempList;
          _isLoading = false;
        });
      } else {
        debugPrint("No data found in 'alumil_dummy'");
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
      appBar: AppBar(
        title: const Text('Product List'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          _isLoading
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
                          title: Text(product['profile_code'] ?? 'No Name'),
                          subtitle: Text(
                            'Profile Type: ${product['profile_type'] ?? 'N/A'}',
                          ),
                        ),
                      ),
                    );
                  },
                ),

          Positioned(
            // child: ElevatedButton(onPressed: () {}, child: Icon(Icons.add)),
            bottom: 25,
            right: 25,
            // child: ElevatedButton(onPressed: () {}, child: Icon(Icons.add)),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(25),
              child: Container(
                color: Colors.blue.shade900,
                child: PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        PopupMenuItem(
                          value: 'Add Single',
                          child: Text('Add single product'),  
                        ),
                        PopupMenuItem(
                          value: 'Add multiple products',
                          child: Text('Add multiple products'),
                        ),
                        PopupMenuItem(
                          value: 'Download',
                          child: Text('Download Current Products'),
                        ),
                      ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
