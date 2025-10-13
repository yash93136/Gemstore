import 'package:flutter/material.dart';
import 'package:gemstore/screen/profile/address.dart';
import 'package:gemstore/screen/profile/mywishlist.dart';
import 'package:gemstore/screen/profile/payment/payment.dart';
import 'package:gemstore/screen/profile/profilesetting.dart';
import 'package:gemstore/screen/profile/rate1.dart';
import 'package:gemstore/screen/profile/voucher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // Hide default app bar for full control
        title: const Text(''),
      ),
      body: Column(
        children: [  
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.pinkAccent,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Sunie Pham',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'sunieu@gmail.com',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 40,),
                        IconButton(
                          icon: const Icon(Icons.settings, color: Colors.black),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ProfileSettingScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    _buildProfileOption(Icons.location_on, 'Address', () { Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeliveryAddressScreen()),
                      );}),
                    _buildProfileOption(Icons.credit_card, 'Payment method', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Paymant()),
                      );
                    }),
                    _buildProfileOption(Icons.receipt, 'Voucher', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VoucherScreen()),
                      );
                    }),
                    _buildProfileOption(Icons.favorite_border, 'My Wishlist', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WishlistPage()),
                      );
                    }),
                    _buildProfileOption(Icons.star_border, 'Rate this app', () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FeedbackScreen()),
                      );
                    }),
                    _buildProfileOption(Icons.logout, 'Log out', () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.black54),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}