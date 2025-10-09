import 'package:flutter/material.dart';
import 'package:gemstore/modal/drawer.dart';
import 'package:gemstore/screen/myorders/order1.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize _tabController here
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // No need for DefaultTabController here if we manage _tabController manually with TickerProviderStateMixin
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Orders',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
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
            onPressed: () {},
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade300),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TabBar(
              controller: _tabController, // Make sure to pass the controller here
              indicator: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(25),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelPadding: const EdgeInsets.symmetric(horizontal: 0),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: "Pending"),
                Tab(text: "Delivered"),
                Tab(text: "Cancelled"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController, // Make sure to pass the controller here
              children: const [
                PendingOrdersPage(),
                DeliveredOrdersPage(),
                CancelledOrdersPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Remaining classes (PendingOrdersPage, DeliveredOrdersPage, CancelledOrdersPage, OrderCard) are unchanged.
// I'm omitting them for brevity in this response, but keep them in your file.

class PendingOrdersPage extends StatelessWidget {
  const PendingOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder (
      padding: const EdgeInsets.all(12),
      itemCount: 4,
      itemBuilder: (context, index) {
        return const OrderCard(
          orderId: "#1524",
          trackingNo: "IK287368838",
          date: "13/05/2021",
          quantity: 2,
          subtotal: 110,
          status: "PENDING",
          statusColor: Colors.deepOrange,
        );
      },
    );
  }
}

//
// ────────────────────────────────
//   DELIVERED ORDERS PAGE
// ────────────────────────────────
//
class DeliveredOrdersPage extends StatelessWidget {
  const DeliveredOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 4,
      itemBuilder: (context, index) {
        return const OrderCard(
          orderId: "#1422",
          trackingNo: "IK237888120",
          date: "05/05/2021",
          quantity: 1,
          subtotal: 150,
          status: "DELIVERED",
          statusColor: Colors.green,
        );
      },
    );
  }
}


class CancelledOrdersPage extends StatelessWidget {
  const CancelledOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 2,
      itemBuilder: (context, index) {
        return const OrderCard(
          orderId: "#1330",
          trackingNo: "IK287377777",
          date: "29/04/2021",
          quantity: 1,
          subtotal: 90,
          status: "CANCELLED",
          statusColor: Colors.redAccent,
        );
      }
     
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderId;
  final String trackingNo;
  final String date;
  final int quantity;
  final double subtotal;
  final String status;
  final Color statusColor;

  const OrderCard({
    Key? key,
    required this.orderId,
    required this.trackingNo,
    required this.date,
    required this.quantity,
    required this.subtotal,
    required this.status,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order ID + Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order $orderId",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                date,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Tracking number
          Text.rich(
            TextSpan(
              text: "Tracking number: ",
              style: TextStyle(color: Colors.grey[600]),
              children: [
                TextSpan(
                  text: trackingNo,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Quantity + Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Quantity: $quantity"),
              Text("Subtotal: \$${subtotal.toStringAsFixed(0)}"),
            ],
          ),
          const SizedBox(height: 10),
          // Status + Details Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsScreen()
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(  
                  side: const BorderSide(color: Colors.black26),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Details",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}