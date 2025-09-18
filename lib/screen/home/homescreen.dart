import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/modal/uihelper.dart';
import 'package:gemstore/newfile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  double get screenWidth => MediaQuery.of(context).size.width;
  final PageController _pageController = PageController();
  int _page = 0;
  Timer? _timer;

  final List<String> sliderImages = [
    AppImages.MaskGroup,
    AppImages.MaskGroup,
    AppImages.MaskGroup,
  ];

  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.female, "title": "Women"},
    {"icon": Icons.male, "title": "Men"},
    {"icon": Icons.watch, "title": "Accessories"},
    {"icon": Icons.brush, "title": "Beauty"},
  ];

  final List<Map<String, dynamic>> products = [
    {"image": AppImages.Products1, "title": "Long Sleeve Dress", "price": 45.0},
    {"image": AppImages.Products2, "title": "Sportwear Set", "price": 80.0},
    {"image": AppImages.Products3, "title": "White Sweater", "price": 35.0},
    {"image": AppImages.Products1, "title": "Denim Jacket", "price": 60.0},
    {"image": AppImages.Products2, "title": "Black Shoes", "price": 55.0},
    {"image": AppImages.Products3, "title": "Summer Top", "price": 25.0},
  ];
  final List<Map<String, dynamic>> Recommended = [
    {"image": AppImages.Products1, "title": "Long Sleeve Dress", "price": 45.0},
    {"image": AppImages.Products2, "title": "Sportwear Set", "price": 80.0},
    {"image": AppImages.Products3, "title": "White Sweater", "price": 35.0},
    {"image": AppImages.Products1, "title": "Denim Jacket", "price": 60.0},
    {"image": AppImages.Products2, "title": "Black Shoes", "price": 55.0},
    {"image": AppImages.Products3, "title": "Summer Top", "price": 25.0},
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_page < sliderImages.length - 1) {
        _page++;
      } else {
        _page = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _page,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade500,
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(child: Text("Menu")),
            ListTile(title: Text("Home")),
            ListTile(title: Text("Profile")),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Gemstore", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white54,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // category buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: categories.map((cat) {
                  return Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        child: Icon(cat["icon"], color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      Text(cat["title"]),
                    ],
                  );
                }).toList(),
              ),
            ),

            // auto scroll PageView
            SizedBox(
              height: 180,
              child: PageView.builder(
                controller: _pageController,
                itemCount: sliderImages.length,
                itemBuilder: (context, index) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          sliderImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 20,
                        bottom: 30,
                        top: 30,
                        child: Text(
                          "Autumn \nCollection\n ${2022 + index}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Feature Products Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Feature Products",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Show all clicked!")),
                      );
                    },
                    child: const Text(
                      "Show all",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 220,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    width: 140,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailScreen(product: product),
                                ),
                              );
                            },
                            child: Image.asset(
                              product["image"],
                              height: 160,
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          product["title"],
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "\$${product["price"]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            UiHelper.customBanner(
              title: "NEW COLLECTION",
              subtitle: "HANG OUT \n& PARTY",
              image: AppImages.collection,
              color: Colors.grey.shade400,
              hight: 200,
            ),
            const SizedBox(height: 20),

            // Feature Products Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recommended",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Show all clicked!")),
                      );
                    },
                    child: const Text(
                      "Show all",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: Recommended.length,
                itemBuilder: (context, index) {
                  final product = Recommended[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailScreen(product: product),
                                ),
                              );
                            },
                            child: Image.asset(
                              product["image"],
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product["title"],
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "\$${product["price"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recommended",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Show all clicked!")),
                      );
                    },
                    child: const Text(
                      "Show all",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            UiHelper.customBanner(
              title: "Sale up to 40%",
              subtitle: "FOR SLIM \n& BEAUTY",
              image: AppImages.forslim,
              color: Colors.grey.shade400,
              hight: 200,
            ),
            UiHelper.customBanner(
              title: "Summer Collection 2021",
              subtitle: "Most sexy\n& fabulous \ndesign ",
              image: AppImages.mostsexy,
              color: Colors.grey.shade400,
              hight: 300,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // -------- Card 1 --------
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: screenWidth * 0.45, // responsive width
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 9,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(20),
                          ),
                          child: Image.asset(
                            AppImages.theshirts,
                            height: double.infinity,
                            width: screenWidth * 0.18, // responsive image
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "T-Shirts",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "The \nOffice \nLife",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // -------- Card 2 --------
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width:
                        MediaQuery.of(context).size.width *
                        0.45, // responsive width
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 9,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Dresses",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "Elegant \nDesign ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Image.asset(
                            AppImages.Eleggant,
                            height: double.infinity,
                            width: MediaQuery.of(context).size.width * 0.18,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // bottom navigation bar
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueGrey,
        color: Colors.blueGrey.shade300,
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.shopping_bag, size: 30),
          Icon(Icons.person_outline, size: 30),
        ],

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
