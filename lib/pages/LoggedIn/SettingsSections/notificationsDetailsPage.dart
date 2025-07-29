import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationSection extends StatefulWidget {
  const NotificationSection({super.key});

  @override
  State<NotificationSection> createState() => _notificationState();
}

class _notificationState extends State<NotificationSection> {
  String? _selectedLanguage = 'English';
  String? _selectedTimeZone =
      'UTC+2 (Athens)'; // TODO: Set the default value to be the selected one when the user started using the app

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                'Notification Preferences',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(25),
              child: Container(
                padding: EdgeInsets.all(35),
                width: double.infinity,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  children: [
                    _buildSectionDevider("General Settings"),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSettingItem('Notifications'),
                        CupertinoSwitch(
                          // overrides the default green color of the track
                          activeTrackColor: Colors.green,
                          // color of the round icon, which moves from right to left
                          thumbColor: Colors.red,
                          // when the switch is off
                          inactiveTrackColor: Colors.black12,
                          // boolean variable value
                          value: true,
                          // changes the state of the switch
                          onChanged: (value) {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSettingItem('Notification Frequency'),
                        DropdownButton<String>(
                          value: 'Low',
                          items: ['Low', 'Mid', 'High'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            print('Selected: $newValue');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(25),
              child: Container(
                padding: EdgeInsets.all(35),
                width: double.infinity,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  children: [
                    _buildSectionDevider("Email Notifications"),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSettingItem('New Password Creation'),
                        CupertinoSwitch(
                          // overrides the default green color of the track
                          activeTrackColor: Colors.green,
                          // color of the round icon, which moves from right to left
                          thumbColor: Colors.red,
                          // when the switch is off
                          inactiveTrackColor: Colors.black12,
                          // boolean variable value
                          value: true,
                          // changes the state of the switch
                          onChanged: (value) {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSettingItem('Changes of a product'),
                        CupertinoSwitch(
                          // overrides the default green color of the track
                          activeTrackColor: Colors.green,
                          // color of the round icon, which moves from right to left
                          thumbColor: Colors.red,
                          // when the switch is off
                          inactiveTrackColor: Colors.black12,
                          // boolean variable value
                          value: true,
                          // changes the state of the switch
                          onChanged: (value) {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSettingItem('Collaboration invites'),
                        CupertinoSwitch(
                          // overrides the default green color of the track
                          activeTrackColor: Colors.green,
                          // color of the round icon, which moves from right to left
                          thumbColor: Colors.red,
                          // when the switch is off
                          inactiveTrackColor: Colors.black12,
                          // boolean variable value
                          value: true,
                          // changes the state of the switch
                          onChanged: (value) {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSettingItem("Products' Updates"),
                        CupertinoSwitch(
                          // overrides the default green color of the track
                          activeTrackColor: Colors.green,
                          // color of the round icon, which moves from right to left
                          thumbColor: Colors.red,
                          // when the switch is off
                          inactiveTrackColor: Colors.black12,
                          // boolean variable value
                          value: true,
                          // changes the state of the switch
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(25),
              child: Container(
                padding: EdgeInsets.all(35),
                width: double.infinity,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  children: [
                    _buildSectionDevider("Push Notifications"),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSettingItem("Collaboration Invites"),
                        CupertinoSwitch(
                          // overrides the default green color of the track
                          activeTrackColor: Colors.green,
                          // color of the round icon, which moves from right to left
                          thumbColor: Colors.red,
                          // when the switch is off
                          inactiveTrackColor: Colors.black12,
                          // boolean variable value
                          value: true,
                          // changes the state of the switch
                          onChanged: (value) {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSettingItem("Products' Updates"),
                        CupertinoSwitch(
                          // overrides the default green color of the track
                          activeTrackColor: Colors.green,
                          // color of the round icon, which moves from right to left
                          thumbColor: Colors.red,
                          // when the switch is off
                          inactiveTrackColor: Colors.black12,
                          // boolean variable value
                          value: true,
                          // changes the state of the switch
                          onChanged: (value) {},
                        ),
                      ],
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

  Widget _buildSectionDevider(String text) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(child: Divider(thickness: 1)),
      ],
    );
  }

  Widget _buildSettingItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _myTextField(String text) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: text,
      ),
    );
  }

  Widget _buildMembershipCarousel() {
    // TODO: Implement carousel of three cards for plans
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'Membership Plans Carousel (TODO)',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return DropdownButton<String>(
      value: _selectedLanguage,
      items: const [
        DropdownMenuItem(value: 'English', child: Text('English')),
        DropdownMenuItem(value: 'Greek', child: Text('Greek')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value;
        });
        print(value);
      },
      borderRadius: BorderRadius.circular(25),
      dropdownColor: Colors.blueGrey,
      isExpanded: true,
    );
  }

  Widget _buildTimeZoneDropdown() {
    return DropdownButton<String>(
      value: _selectedTimeZone,
      items: const [
        DropdownMenuItem(
          value: 'UTC+2 (Athens)',
          child: Text('UTC+2 (Athens)'),
        ),
        DropdownMenuItem(
          value: 'UTC+1 (London)',
          child: Text('UTC+1 (London)'),
        ),
        DropdownMenuItem(value: 'UTC (Lisbon)', child: Text('UTC (Lisbon)')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedTimeZone = value;
        });
      },
      borderRadius: BorderRadius.circular(25),
      dropdownColor: Colors.blueGrey,
      isExpanded: true,
    );
  }

  void _downloadBillingHistory() {
    print(
      'Downloading billing history...',
    ); // TODO: Create a page to see all the available history billing information and be downloadable to a pdf
  }
}
