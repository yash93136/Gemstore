import 'package:flutter/material.dart';
import 'package:gemstore/modal/drawer.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/screen/notifications.dart';
import 'package:gemstore/screen/product.dart';


class WishlistPage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
     {"image": AppImages.popular1, "title": "Lihua Tunic White", "price": 51.0, "rating": 38},
    {"image": AppImages.popular2, "title": "Skirt Dress", "price": 34.0, "rating": 50},
    {"image": AppImages.popular3, "title": "Kimi Green Dress", "price": 47.99, "rating": 42},
    {"image": AppImages.filtedWaistDress, "title": "Filted Waist Dress", "price": 60.0, "rating": 60},
    {"image": AppImages.frontTieMiniDress, "title": "Front Tie Mini Dress", "price": 59.00, "rating": 38},
    {"image": AppImages.leavesGreenDress, "title": "Leaves Green Dress", "price": 64.0, "rating": 55},
    {"image": AppImages.linenDress, "title": "Linen Dress", "price": 52.00, "rating": 64},
    {"image": AppImages.offShoulderDress, "title": "Off Shoulder Dress", "price": 78.00, "rating": 70},
    {"image": AppImages.oharaDress, "title": "Ohara Dress", "price": 85.00, "rating": 50},
    {"image": AppImages.tieBackMiniDress, "title": "Tie Back Mini Dress", "price": 67.00, "rating": 39},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Wishlist',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
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
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
            },
          ),
        ],
      ),
      drawer: CustomDrawer(currentPage: 'myorders',), // Assuming 'myorders' is a placeholder for the current page
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.65, // Adjust this as needed
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return WishlistCard(
                    image: product["image"],
                    title: product["title"],
                    price: product["price"],
                    rating: product["rating"],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: product,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
     
    );
  }
}

class WishlistCard extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final int rating;
  final VoidCallback onTap;

  const WishlistCard({
    required this.image,
    required this.title,
    required this.price,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white, // Ensure background is white as per image
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    image,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 240, // Fixed height for image consistency
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite, color: Colors.red, size: 18), // Filled heart for wishlist items
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${price.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow[700], size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${(rating / 10).toStringAsFixed(1)}', // Assuming rating is out of 100, converting to 1-10 scale
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    ' ($rating)',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}