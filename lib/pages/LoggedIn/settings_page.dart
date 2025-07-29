import 'package:flutter/material.dart';
import 'package:generalized_dpp/pages/LoggedIn/SettingsSections/accountDetailsPage.dart';
import 'package:generalized_dpp/pages/LoggedIn/SettingsSections/locDetailsPage.dart';
import 'package:generalized_dpp/pages/LoggedIn/SettingsSections/notificationsDetailsPage.dart';
import 'package:generalized_dpp/pages/LoggedIn/SettingsSections/organizationDetailsPage.dart';
import 'package:generalized_dpp/pages/LoggedIn/SettingsSections/privacyDetailsPage.dart';
import 'package:generalized_dpp/pages/LoggedIn/SettingsSections/regulationsDetailsPage.dart';
import 'package:generalized_dpp/pages/LoggedIn/SettingsSections/supportDetailsPage.dart';
import 'package:lottie/lottie.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _settingsState();
}

class _settingsState extends State<SettingsPage> {
  
  int _selectedSection = 0;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text("Settings Page"),
          automaticallyImplyLeading: true,
        ),
      
      drawer: _BuildDrawer(),
      
      body: _BuildSelectedSection(),

    );
  }

  Widget _BuildSelectedSection() {
  switch (_selectedSection) {
    case 0 : return const AccountDetailsSection();
    case 1 : return const OrganizationDetailsSection();
    case 2 : return const NotificationSection();
    case 3 : return const PrivacyDetailsSection();
    case 4 : return const LocalizationDetailsSection();
    case 5 : return const RegulationsDetailsSection();
    case 6 : return const SupportDetailsSection();
    default :
      return const Center(child: Text ('Section not found'));
    }
  }

  Widget _BuildDrawer () {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Text('Settings'),
                
                SizedBox(
                  height: 100,
                  child: Lottie.asset('assets/lottieFiles/Settings1.json'),
                ),   
              ],
            )
          ),      
          SizedBox(height: 40),
          _buildDrawerItem(0, Icons.account_circle, 'Account Details'),
          _buildDrawerItem(1, Icons.apartment_sharp, 'Organization / Company Settings'),
          _buildDrawerItem(2, Icons.notification_important, 'Notifications'),
          _buildDrawerItem(3, Icons.privacy_tip_rounded, 'Privacy & Data'),
          _buildDrawerItem(4, Icons.location_on, 'Localization & Language'),
          _buildDrawerItem(5, Icons.security_rounded, 'Regulatory & Compliance'),
          _buildDrawerItem(6, Icons.settings, 'Support & Feedback'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(int index, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: _selectedSection == index,
      onTap: () {
        setState(() {
          setState(()=> _selectedSection = index);
          Navigator.pop(context);
        });
      },
    );
  }

}
