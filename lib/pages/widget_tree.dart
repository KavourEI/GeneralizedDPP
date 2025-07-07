import 'package:flutter/material.dart';
import 'package:generalized_dpp/Widgets/navBarWidget.dart';
import 'package:generalized_dpp/data/notifiers.dart';
import 'package:generalized_dpp/pages/LoggedIn/home_page.dart';
import 'package:generalized_dpp/pages/LoggedIn/items_page.dart';
import 'package:generalized_dpp/pages/LoggedIn/profile_page.dart';
import 'package:generalized_dpp/pages/LoggedIn/settings_page.dart';

List<Widget> pages = [
  HomePage(),
  ItemsPage(),
  SettingsPage(),
  ProfilePage(),
];

class WidgetTree extends StatelessWidget{
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(valueListenable: selectedPageNotifier, builder: (context, selectedPage, child) {
        return pages.elementAt(selectedPage);
      },),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}