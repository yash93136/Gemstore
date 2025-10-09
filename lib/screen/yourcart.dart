import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/screen/checkoutscreen/checkout1.dart';

class YourCart extends StatefulWidget {
  const YourCart({super.key});

  @override
  State<YourCart> createState() => _YourCartState();
}

class _YourCartState extends State<YourCart> {
  List<CartItem> cartItems = [
    CartItem(
      name: "Sportwear Set",
      price: 80.00,
      size: "L",
      color: "Cream",
      imageUrl: AppImages.popular2, // Replace with actual image URL
      quantity: 1,
      isChecked: true,
    ),
    CartItem(
      name: "Turtleneck Sweater",
      price: 39.99,
      size: "M",
      color: "White",
      imageUrl: AppImages.linenDress, // Replace with actual image URL
      quantity: 1,
      isChecked: true,
    ),
    CartItem(
      name: "Cotton T-shirt",
      price: 30.00,
      size: "L",
      color: "Black",
      imageUrl: AppImages.leavesGreenDress, // Replace with actual image URL
      quantity: 1,
      isChecked: true,
    ),
    CartItem(
      name: "Sportwear Set",
      price: 80.00,
      size: "L",
      color: "Cream",
      imageUrl: AppImages.popular2, // Replace with actual image URL
      quantity: 1,
      isChecked: true,
    ),
    CartItem(
      name: "Sportwear Set",
      price: 80.00,
      size: "L",
      color: "Cream",
      imageUrl: AppImages.popular2, // Replace with actual image URL
      quantity: 1,
      isChecked: true,
    ),
  ];
   double get productPrice {
    return cartItems.fold(0.0, (sum, item) {
      return sum + (item.isChecked ? item.price * item.quantity : 0);
    });
  }

  double get subtotal {
    return productPrice; // Assuming no shipping cost for subtotal calculation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16, top: 16),
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
                        'Your Cart',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(14.0),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItemCard(
                  item: cartItems[index],
                  onChanged: (bool? value) {
                    setState(() {
                      cartItems[index].isChecked = value ?? false;
                    });
                  },
                  onQuantityChanged: (int newQuantity) {
                    setState(() {
                      cartItems[index].quantity = newQuantity;
                    });
                  },
                );
              },
            ),
          ),
           _buildPriceSummary(),
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  Widget _buildPriceSummary() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 5)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Product price",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              Text(
                "\$${productPrice.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        Divider(height: 30, thickness: 1, color: Colors.grey.shade300),
            
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              
           Text(
                "Freeship",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ],
          ),
          Divider(height: 30, thickness: 1, color: Colors.grey.shade300),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${subtotal.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Checkout1Screen())); // Example navigation
        
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
            elevation: 0, // No shadow
          ),
          child: Text(
            "Proceed to checkout",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CartItem {
  String name;
  double price;
  String size;
  String color;
  String imageUrl;
  int quantity;
  bool isChecked;

  CartItem({
    required this.name,
    required this.price,
    required this.size,
    required this.color,
    required this.imageUrl,
    this.quantity = 1,
    this.isChecked = true,
  });
}

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final ValueChanged<bool?> onChanged;
  final ValueChanged<int> onQuantityChanged;

  CartItemCard({
    required this.item,
    required this.onChanged,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      color: Colors.grey.shade100,
      shadowColor: Colors.black,
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            item.imageUrl,
            width: 110,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "\$${item.price.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                SizedBox(height: 4),
                Text(
                  "Size: ${item.size} | Color: ${item.color}",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Checkbox(
                value: item.isChecked,
                onChanged: onChanged,
                activeColor: Colors.green.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: BorderSide(color: Colors.grey),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 16),
                            onPressed: () {
                              if (item.quantity > 1) {
                                onQuantityChanged(item.quantity - 1);
                              }
                            },
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 16),
                            onPressed: () {
                              onQuantityChanged(item.quantity + 1);
                            },
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
            ],
          ),
        ],
      )
    );
  }
}