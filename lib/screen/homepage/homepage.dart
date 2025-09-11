import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gemstore/images.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_outlined),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('GemStore'),
        centerTitle: true,
        actions: [
          // Dark Mode Toggle Button
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.toggleTheme,
            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications clicked!')),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              title: Text(isDark ? 'Light Mode' : 'Dark Mode'),
              onTap: () {
                widget.toggleTheme();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AutumnCollectionSection(),
              //
              //
              //
              ///
              PromoBanner(),
            ],
          ),
        ),
      ),
    );
  }
}

class AutumnCollectionSection extends StatefulWidget {
  const AutumnCollectionSection({super.key});

  @override
  _AutumnCollectionSectionState createState() =>
      _AutumnCollectionSectionState();
}

class _AutumnCollectionSectionState extends State<AutumnCollectionSection> {
  final List<dynamic> imagePaths = [
    'assets/images/p1.png',
    'assets/images/p1.png',
    'assets/images/p1.png',
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(8),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          enlargeCenterPage: true,
          viewportFraction: 0.9,
        ),
        items: imagePaths.map((path) {
          return Builder(
            builder: (BuildContext context) {
              return Stack(
                children: [
                  /// Background Image
                  Container(
                    width: height,
                    height: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 20,
                    right: 20,
                    top: 5,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        'Autumn\nCollection\n2021',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black45,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class PromoBanner extends StatefulWidget {
  @override
  _PromoBannerState createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  bool _isHighlighted = false;

  void _toggleHighlight() {
    setState(() {
      _isHighlighted = !_isHighlighted;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: _toggleHighlight,
      child: Container(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'NEW COLLECTION',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'HANG OUT ',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: _isHighlighted
                        ? Colors.blue
                        : (isDark ? Colors.white : Colors.black87),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '& PARTY',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: _isHighlighted
                        ? Colors.blue
                        : (isDark ? Colors.white : Colors.black87),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Shoe image
                    Image.asset(
                      'assets/images/p3.png',
                      height: 130.0,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 130.0,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey[700] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
