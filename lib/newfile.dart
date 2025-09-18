import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 🔙 Back button aur product image
            Stack(
              children: [
                Image.asset(
                  product["image"],
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            // Product details
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product["title"],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${product["price"]}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Dummy description
                    const Text(
                      "Sportswear is no longer under culture, it is no longer indie or cobbled together as it once was. Sport is fashion today.",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),

                    // Color options
                    const Text(
                      "Color",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        CircleAvatar(backgroundColor: Colors.brown, radius: 14),
                        const SizedBox(width: 8),
                        CircleAvatar(backgroundColor: Colors.black, radius: 14),
                        const SizedBox(width: 8),
                        CircleAvatar(backgroundColor: Colors.red, radius: 14),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Size options
                    const Text(
                      "Size",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        ChoiceChip(label: Text("S"), selected: false),
                        const SizedBox(width: 8),
                        ChoiceChip(label: Text("M"), selected: false),
                        const SizedBox(width: 8),
                        ChoiceChip(label: Text("L"), selected: true),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Reviews (dummy)
                    const Text(
                      "Reviews",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/user1.png"),
                      ),
                      title: const Text("Jennifer Rose"),
                      subtitle: const Text(
                        "I love it. Awesome customer service!",
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/user2.png"),
                      ),
                      title: const Text("Kelly Rihana"),
                      subtitle: const Text("Delivered on time, good quality."),
                    ),
                  ],
                ),
              ),
            ),

            // Add to Cart Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // Add to cart logic
                },
                child: const Text(
                  "Add To Cart",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
