import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalized_dpp/pages/widget_tree.dart';

class SingleAdditionPage extends StatefulWidget {
  const SingleAdditionPage({super.key});

  @override
  State<SingleAdditionPage> createState() => _singleAddState();
}

class _singleAddState extends State<SingleAdditionPage> {
  final TextEditingController _profileCodeController = TextEditingController();
  final TextEditingController _certificationsController = TextEditingController();
  final TextEditingController _finishingOptionsController = TextEditingController();
  final TextEditingController _materialAlloyController = TextEditingController();
  final TextEditingController _maxGlazingthicknessController = TextEditingController();
  final TextEditingController _profileTypeController = TextEditingController();
  final TextEditingController _recycledContentPctController = TextEditingController();
  final TextEditingController _systemSeriesController = TextEditingController();
  final TextEditingController _thermalBreakController = TextEditingController();
  final TextEditingController _uValuesController = TextEditingController();

  String? _checkResult;
  String? _dialogMessage;

  CollectionReference db = FirebaseFirestore.instance.collection('alumil_dummy');

  Future<void> _checkProfileCodeExists() async {
    final profileCode = _profileCodeController.text.trim();
    if (profileCode.isEmpty) {
      setState(() {
        _checkResult = "Profile code cannot be empty";
        _dialogMessage = "Please fill profile_code";
      });
      return;
    }

    final querySnapshot = await db.where('profile_code', isEqualTo: profileCode).get();

    setState(() {
      if (querySnapshot.docs.isNotEmpty) {
        _checkResult = "Profile code exists!";
        _dialogMessage = 'Search data displayed in products list or change product_code.';
      } else {
        _checkResult = "Profile code does NOT exist.";
        _dialogMessage = 'You can add a new product with this profile_code.';
      }
    });
  }

  Future<void> _addProduct() async {
    final profileCode = _profileCodeController.text.trim();

    if (profileCode.isEmpty) {
      // Prevent adding product with empty profile_code
      setState(() {
        _checkResult = "Profile code cannot be empty";
        _dialogMessage = "Please fill profile_code before adding a product";
      });
      return;
    }

    // Optional: Check again if profile_code exists before adding
    final querySnapshot = await db.where('profile_code', isEqualTo: profileCode).get();
    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        _checkResult = "Cannot add product";
        _dialogMessage = "This profile_code already exists. Please choose another one.";
      });
      return;
    }

    try {
      await db.doc(profileCode).set({
        'profile_code': profileCode,
        'certifications': _certificationsController.text.trim(),
        'finishing_options': _finishingOptionsController.text.trim(),
        'material_alloy': _materialAlloyController.text.trim(),
        'max_glazing_thickness': _maxGlazingthicknessController.text.trim(),
        'profile_type': _profileTypeController.text.trim(),
        'recycled_content_pct': _recycledContentPctController.text.trim(),
        'system_series': _systemSeriesController.text.trim(),
        'thermal_break': _thermalBreakController.text.trim(),
        'u_value': _uValuesController.text.trim(),
      });

      setState(() {
        _checkResult = "Product Added Successfully!";
        _dialogMessage = "Your new product has been added.";
      });

      _clearAllFields();
    } catch (e) {
      setState(() {
        _checkResult = "Failed to add product";
        _dialogMessage = "Error: $e";
      });
    }
  }

  // Helper to clear all text fields after successful add
  void _clearAllFields() {
    _profileCodeController.clear();
    _certificationsController.clear();
    _finishingOptionsController.clear();
    _materialAlloyController.clear();
    _maxGlazingthicknessController.clear();
    _profileTypeController.clear();
    _recycledContentPctController.clear();
    _systemSeriesController.clear();
    _thermalBreakController.clear();
    _uValuesController.clear();
  }

  @override
  void dispose() {
    _profileCodeController.dispose();
    _certificationsController.dispose();
    _finishingOptionsController.dispose();
    _materialAlloyController.dispose();
    _maxGlazingthicknessController.dispose();
    _profileTypeController.dispose();
    _recycledContentPctController.dispose();
    _systemSeriesController.dispose();
    _thermalBreakController.dispose();
    _uValuesController.dispose();
    super.dispose();
  }

  Widget _newProductFeature(String text, {TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Single Product Addition Page"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "In this page you can add new products by writing the details of it. In case this product already exists this application will let you know.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
            ),

            _newProductFeature('profile_code', controller: _profileCodeController),
            _newProductFeature('certifications', controller: _certificationsController),
            _newProductFeature('finishing_options', controller: _finishingOptionsController),
            _newProductFeature('material_alloy', controller: _materialAlloyController),
            _newProductFeature('max_glazing_thickness', controller: _maxGlazingthicknessController),
            _newProductFeature('profile_type', controller: _profileTypeController),
            _newProductFeature('recycled_content_pct', controller: _recycledContentPctController),
            _newProductFeature('system_series', controller: _systemSeriesController),
            _newProductFeature('thermal_break', controller: _thermalBreakController),
            _newProductFeature('u_value', controller: _uValuesController),

            ElevatedButton(
              onPressed: () async {
                await _checkProfileCodeExists();

                if (_checkResult != null && _dialogMessage != null) {
                  await showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Text(_checkResult!),
                        content: Text(_dialogMessage!),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('Continue'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                }

                // Only add product if profile_code does NOT exist
                if (_checkResult == "Profile code does NOT exist.") {
                  await _addProduct();

                  if (_checkResult == "Product Added Successfully!" && _dialogMessage == "Your new product has been added.") {
                    await showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text(_checkResult!),
                          content: Text(_dialogMessage!),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('OK'),
                              onPressed: () => Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => WidgetTree())),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (_checkResult != null && _dialogMessage != null) {
                    // Show the result of add operation
                    await showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text(_checkResult!),
                          content: Text(_dialogMessage!),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('OK'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              child: Text('Create new product'),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
