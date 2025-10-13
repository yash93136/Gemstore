import 'package:flutter/material.dart';
import 'package:gemstore/modal/drawer.dart';
import 'package:gemstore/screen/notifications.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white54,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
       actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none, color: Colors.black),
                Positioned(
                  right: 3,
                  top: 3,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) =>NotificationScreen()));},
          ),
        ],
      ),
      drawer: CustomDrawer(currentPage: 'Setting'),
      body: ListView(
        children: [
          _buildSettingItem(
            context,
            icon: Icons.language,
            title: 'Language',
            onTap: () {
              // Handle language tap
            },
          ),
          _buildSettingItem(
            context,
            icon: Icons.notifications_none,
            title: 'Notification',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationSettingScreen()),
              );
            },
          ),
          _buildSettingItem(
            context,
            icon: Icons.description_outlined,
            title: 'Terms of Use',
            onTap: () {
              // Handle terms of use tap
            },
          ),
          _buildSettingItem(
            context,
            icon: Icons.info_outline,
            title: 'Privacy Policy',
            onTap: () {
              // Handle privacy policy tap
            },
          ),
          _buildSettingItem(
            context,
            icon: Icons.chat_bubble_outline,
            title: 'Chat support',
            onTap: () {
              // Handle chat support tap
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: onTap,
        ),
        Divider(height: 1, indent: 16, endIndent: 16), // Add a divider below each item
      ],
    );
  }
}

class NotificationSettingScreen extends StatefulWidget {
  @override
  _NotificationSettingScreenState createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool _showNotifications = true;
  bool _notificationSounds = true;
  bool _lockScreenNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: ListView(
        children: [
          _buildNotificationToggle(
            title: 'Show notifications',
            subtitle: 'Receive push notifications for new messages',
            value: _showNotifications,
            onChanged: (bool newValue) {
              setState(() {
                _showNotifications = newValue;
              });
            },
          ),
          _buildNotificationToggle(
            title: 'Notification sounds',
            subtitle: 'Play sound for new messages',
            value: _notificationSounds,
            onChanged: (bool newValue) {
              setState(() {
                _notificationSounds = newValue;
              });
            },
          ),
          _buildNotificationToggle(
            title: 'Lock screen notifications',
            subtitle: 'Allow notification on the lock screen',
            value: _lockScreenNotifications,
            onChanged: (bool newValue) {
              setState(() {
                _lockScreenNotifications = newValue;
              });
            },
            inactiveTrackColor: Colors.grey[300], // Custom color for inactive track
            activeColor: const Color.fromARGB(255, 35, 66, 36), // Custom color for active thumb
            activeTrackColor: const Color.fromARGB(255, 35, 66, 36).withOpacity(0.5), // Custom color for active track
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color? inactiveTrackColor,
    Color? activeColor,
    Color? activeTrackColor,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          trailing: Transform.scale(
            scale: 0.8, // Adjust scale to make the switch smaller if needed
            child: Switch(
              value: value,
              onChanged: onChanged,
            // activeColor: activeColor ?? Theme.of(context).primaryColor, // Default to theme primary
              activeTrackColor: activeTrackColor ?? Theme.of(context).primaryColor.withOpacity(0.5), // Default to theme primary
              inactiveThumbColor: Colors.white, // White thumb when off
              inactiveTrackColor: inactiveTrackColor ?? Colors.grey[400], // Grey track when off
            ),
          ),
        ),
        Divider(height: 1, indent: 16, endIndent: 16),
      ],
    );
  }
}