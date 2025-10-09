import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/screen/home/homepage.dart';
import 'package:gemstore/screen/myorders/trackorder.dart';

class OrderDetails2Screen extends StatefulWidget {
  const OrderDetails2Screen({super.key});

  @override
  State<OrderDetails2Screen> createState() => _OrderDetails2ScreenState();
}

class _OrderDetails2ScreenState extends State<OrderDetails2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Added SingleChildScrollView here
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                           decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new,
                                size: 20, color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                        'Order #1524',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            _buildOrderStatusCard(context),
            const SizedBox(height: 20),
            _buildOrderInfoCard(),
            const SizedBox(height: 20),
            _buildOrderSummaryCard(),
            const SizedBox(height: 20), // Added some space before buttons
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusCard(BuildContext context) {
    return Card(
      color: const Color(0xFF424242), // Dark grey
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your order is on the way', // Changed text
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: (){
Navigator.push(context,  MaterialPageRoute(builder: (context) =>  TrackOrderScreen()));
                    },
                    child: const Text(
                      'Click here to track your order',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
           Image.asset(
            AppImages.trackicon,
            width: 60,
            height: 60,
            fit: BoxFit.fill,
           )
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfoRow('Order number', '#1514'),
            const Divider(),
            _buildInfoRow('Tracking Number', 'IK987362341'),
            const Divider(),
            _buildInfoRow('Delivery address', 'SBI Building, Software Park'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSummaryItem('Maxi Dress', 'x1', '\$68.00'),
           const SizedBox(height: 5),
            _buildSummaryItem('Linen Dress', 'x1', '\$52.00'),
            const Divider(),
            const SizedBox(height: 10),
            _buildSummaryRow('Sub Total', '\$120.00', isBold: true),
            const SizedBox(height: 5),
            _buildSummaryRow('Shipping', '\$0.00',isBold: true),
            const SizedBox(height: 10),
            const Divider(thickness: 1.5),
            const SizedBox(height: 10),
            _buildSummaryRow('Total', '\$120.00', isBold: true, isLarge: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String name, String quantity, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            quantity,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 80, // Fixed width for price to align
            child: Text(
              price,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isBold = false, bool isLarge = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isLarge ? 18 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.black : Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isLarge ? 18 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Handle "Rate"
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomePage()));
        
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 11, 11, 11), // Dark grey
              padding: const EdgeInsets.symmetric(vertical: 17),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Continue shopping',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}