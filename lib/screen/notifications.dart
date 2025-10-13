import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Lighter background for a cleaner look
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1, // A subtle shadow for the app bar
        title: const Text(
          'Notifications', // Plural sounds more natural
          style: TextStyle(
            color: Colors.black87, // Slightly softer black
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87), // Ensure back button is visible
      ),
      body: ListView( // Use ListView for scrollability if more notifications are added
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNotificationCard(
            title: 'Good morning! Get 20% Voucher',
            subtitle: 'Summer sale up to 20% off. Limited voucher. Get now!! 😉',
            color: Colors.orange.shade50, // Light orange background for emphasis
          ),
          const SizedBox(height: 12), // Slightly reduced spacing
          _buildNotificationCard(
            title: 'Special offer just for you',
            subtitle: 'New Autumn Collection 30% off',
            color: Colors.blue.shade50, // Light blue background
          ),
          const SizedBox(height: 12),
          _buildNotificationCard(
            title: 'Holiday sale 50%',
            subtitle: 'Tap here to get 50% voucher.',
            color: Colors.green.shade50, // Light green background
          ),
          const SizedBox(height: 12),
          // Example of a 'read' notification
          _buildNotificationCard(
            title: 'Your order has been shipped!',
            subtitle: 'Tracking number: #ABC123XYZ. Expect delivery in 3-5 days.',
            color: Colors.white, // Default white for regular notifications
            isRead: true, // Indicate it's read
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String subtitle,
    Color color = Colors.white, // Default color
    bool isRead = false,
  }) {
    return Card(
      margin: EdgeInsets.zero, // Remove default card margin to control spacing with SizedBox
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Slightly less rounded corners
      ),
      elevation: isRead ? 0.5 : 2, // Less elevation for read notifications
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isRead ? Colors.grey[700] : Colors.black87, // Grey out title if read
                    ),
                  ),
                  const SizedBox(height: 6), // Reduced space
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: isRead ? Colors.grey[500] : Colors.grey[600], // Grey out subtitle if read
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}