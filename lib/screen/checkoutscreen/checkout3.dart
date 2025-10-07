import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';


class OrderCompletedScreen extends StatefulWidget {
  @override
  State<OrderCompletedScreen> createState() => _OrderCompletedScreenState();
}

class _OrderCompletedScreenState extends State<OrderCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  Spacer(),
                  Text('Check out', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Spacer(flex: 2),
                ],
              ),
            ),

            // Progress Indicator
           Row(
  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: Colors.black, size: 30),
                        const SizedBox(width: 4),
                        Row(
                          children: List.generate(
                            5, // Number of dots
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20 ),
                        Icon(Icons.credit_card, color: Colors.black, size: 30),
                        const SizedBox(width: 20 ),
                         Row(
                          children: List.generate(
                            5, // Number of dots
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.check_circle_rounded, color: Colors.black, size: 30),
                      ],
                    ),

            SizedBox(height: 70),

            // Order Completed Icon
          Image.asset(
  AppImages.begorder, // Change to your desired image path
  width: 120,
  height: 120,
  fit: BoxFit.cover,
),

            SizedBox(height: 50),

            // Order Completed Text
            Text(
              "Order Completed",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            Text(
              "Thank you for your purchase.\nYou can view your order in ‘My Orders’ section.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            Spacer(),

            // Continue Shopping Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to shopping screen
                  },
                  child: Text(
                    "Continue shopping",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
