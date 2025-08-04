import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrganizationDetailsSection extends StatefulWidget {
  const OrganizationDetailsSection({super.key});

  @override
  State<OrganizationDetailsSection> createState() => _OrganizationSetState();
}

class _OrganizationSetState extends State<OrganizationDetailsSection> {
  final TextEditingController _controllerOrgName = TextEditingController();
  final TextEditingController _controllerVAT = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerCountry = TextEditingController();
  final TextEditingController _controllerOrgEmail = TextEditingController();

  bool _isloading = true;
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchOrgData();
  }

  Future<void> _fetchOrgData() async {
    try {
      DocumentSnapshot orgData = await FirebaseFirestore.instance
          .collection('settings')
          .doc('organizationSettings')
          .get();

      setState(() {
        final data = orgData.data() as Map<String, dynamic>? ?? {};
        _controllerOrgName.text = data['orgName'] ?? '';
        _controllerVAT.text = data['vat'] ?? '';
        _controllerAddress.text = data['orgAddress'] ?? '';
        _controllerCountry.text = data['orgCountry'] ?? '';
        _controllerOrgEmail.text = data['orgEmail'] ?? '';
        _isloading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to load Organization Data";
        _isloading = false;
      });
    }
  }

  Future<void> _saveOrgData() async {
    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      await FirebaseFirestore.instance
          .collection('settings')
          .doc('organizationSettings')
          .set({
            'orgName': _controllerOrgName.text,
            'vat': _controllerVAT.text,
            'orgAddress': _controllerAddress.text,
            'orgCountry': _controllerCountry.text,
            'orgEmail': _controllerOrgEmail.text,
            'lastUpdated': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to update Organization profile: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  void dispose() {
    _controllerOrgName.dispose();
    _controllerAddress.dispose();
    _controllerCountry.dispose();
    _controllerOrgEmail.dispose();
    _controllerVAT.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isloading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Organization/Company Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                padding: const EdgeInsets.all(35),
                width: double.infinity,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  children: [
                    _buildSectionDivider("Organization Details"),

                    _buildSettingItem('Organization Name'),
                    _myTextField(_controllerOrgName),

                    const SizedBox(height: 10),
                    _buildSettingItem('Company Registration Number / VAT'),
                    _myTextField(_controllerVAT),

                    const SizedBox(height: 10),
                    _buildSettingItem("Organization's Email"),
                    _myTextField(_controllerOrgEmail),

                    const SizedBox(height: 10),
                    _buildSettingItem('Address'),
                    _myTextField(_controllerAddress),

                    const SizedBox(height: 10),
                    _buildSettingItem('Country'),
                    _myTextField(_controllerCountry),

                    const SizedBox(height: 10),
                    _buildSettingItem('Company Logo here'),

                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _saveOrgData,
                        child: _isSaving 
                            ? const CircularProgressIndicator()
                            : const Text('Save Settings'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionDivider(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const Expanded(child: Divider(thickness: 1)),
      ],
    );
  }

  Widget _buildSettingItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _myTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}