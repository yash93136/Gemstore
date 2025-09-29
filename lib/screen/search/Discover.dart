import 'package:flutter/material.dart';
import 'package:gemstore/modal/drawer.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/screen/search/searchpage.dart';
import 'package:gemstore/utils/kyes.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> with TickerProviderStateMixin {
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  bool _expandedClothing = false;
  bool _expandedShoes = false;
  bool _dressesExpanded = false;
  bool _expandedAccessories = false;
  bool _expandedCOLLECTION = false;
  TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late AnimationController _headerAnimationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerAnimationController, curve: Curves.easeIn),
    );
    _headerAnimationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    _headerAnimationController.dispose();
    super.dispose();
  }

  void _toggleAccessories() {
    setState(() {
      _expandedAccessories = !_expandedAccessories;
    });
  }

  void _toggleCOLLECTION() {
    setState(() {
      _expandedCOLLECTION = !_expandedCOLLECTION;
    });
  }

  void _toggleClothing() {
    setState(() {
      _expandedClothing = !_expandedClothing;
    });
  }

  void _toggleShoes() {
    setState(() {
      _expandedShoes = !_expandedShoes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Keys.endDrawreKey,
      appBar: AppBar(
        title: const Text(
          "Discover",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Notifications opened"),
                  backgroundColor: Colors.blue,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      endDrawer: Drawer2(),
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.search, color: Colors.grey),
                                      SizedBox(width: 8),
                                      Text(
                                        'Search',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.tune, color: Colors.grey.shade700),
                        onPressed: () {
                          Keys.endDrawreKey.currentState?.openEndDrawer();
                        },
                      ),
                    ),

                    SizedBox(width: 10),
                  ],
                ),
              ),
              SizedBox(height: 24),
              SingleChildScrollView(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      // ---------------- CLOTHING ----------------
                      GestureDetector(
                        onTap: _toggleClothing,
                        child: Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        AppImages.discovercolor1,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: screenWidth * 0.20),
                                        const Text(
                                          "CLOTHING",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: screenWidth * 0.2),
                                    Image.asset(
                                      AppImages.discover1,
                                      width: screenWidth * 0.3,
                                      height: screenHeight * 0.50,
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      AnimatedSize(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: _expandedClothing
                            ? Container(
                                margin: EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 15,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Column(
                                    children: [
                                      _buildItem("Jacket", 128),
                                      _buildItem("Skirts", 40),
                                      _buildExpandableItem("Dresses", 36),
                                      _buildItem("T-Shirts", 12),
                                      _buildItem("Pants", 9),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink(), // jab collapse ho to kuch na dikhaye
                      ),

                      SizedBox(height: 20),

                      // ---------------- ACCESSORIES ----------------
                      GestureDetector(
                        onTap: _toggleAccessories,
                        child: Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        AppImages.discovercolor2,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "ACCESSORIES",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: screenWidth * 0.1),
                                    Image.asset(
                                      AppImages.discover2,
                                      width: screenWidth * 0.4,
                                      height: screenHeight * 0.50,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      AnimatedSize(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: _expandedAccessories
                            ? Container(
                                margin: EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 15,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Column(
                                    children: [
                                      _buildItem("Sneakers", 52),
                                      _buildItem("Boots", 30),
                                      _buildItem("Sandals", 18),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink(), // jab collapse ho to kuch na dikhaye
                      ),

                      SizedBox(height: 20),

                      // ---------------- SHOES ----------------
                      GestureDetector(
                        onTap: _toggleShoes,
                        child: Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        AppImages.discovercolor3,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: screenWidth * 0.20),
                                        const Text(
                                          "SHOES",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: screenWidth * 0.2),
                                    Image.asset(
                                      AppImages.discover3,
                                      width: screenWidth * 0.3,
                                      height: screenHeight * 0.50,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      AnimatedSize(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: _expandedShoes
                            ? Container(
                                margin: EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 15,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Column(
                                    children: [
                                      _buildItem("Sneakers", 52),
                                      _buildItem("Boots", 30),
                                      _buildItem("Sandals", 18),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink(), // jab collapse ho to kuch na dikhaye
                      ),
                      //nsdcghh
                      SizedBox(height: 20),

                      // ---------------- COLLECTION ----------------
                      GestureDetector(
                        onTap: _toggleCOLLECTION,
                        child: Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        AppImages.discovercolor4,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: screenWidth * 0.20),
                                        const Text(
                                          "COLLECTION",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: screenWidth * 0.2),
                                    Image.asset(
                                      AppImages.discover4,
                                      width: screenWidth * 0.3,
                                      height: screenHeight * 0.50,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      AnimatedSize(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: _expandedCOLLECTION
                            ? Container(
                                margin: EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 15,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Column(
                                    children: [
                                      _buildItem("Sneakers", 52),
                                      _buildItem("Boots", 30),
                                      _buildItem("Sandals", 18),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink(), // jab collapse ho to kuch na dikhaye
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(String title, int count, {bool isLast = false}) {
    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "$count Items",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
        onTap: () {
          print("Selected: $title");
          _navigateToCategory(title, count);
        },
      ),
    );
  }

  Widget _buildExpandableItem(String title, int count) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100, width: 1),
            ),
          ),
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "$count Items",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                AnimatedRotation(
                  turns: _dressesExpanded ? 0.5 : 0.0,
                  duration: Duration(milliseconds: 200),
                  child: Icon(Icons.expand_more, color: Colors.grey.shade400),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                _dressesExpanded = !_dressesExpanded;
              });
            },
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _dressesExpanded ? 120 : 0,
          child: Container(
            color: Colors.grey.shade50,
            child: _dressesExpanded
                ? Column(
                    children: [
                      _buildSubItem("Sweaters", 24),
                      _buildSubItem("Jeans", 14),
                    ],
                  )
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSubItem(String title, int count) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 48, right: 16),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, color: Colors.black54),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$count Items",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
            SizedBox(width: 8),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 18),
          ],
        ),
        onTap: () {
          print("Selected sub-item: $title");
          _navigateToCategory(title, count);
        },
      ),
    );
  }

  void _navigateToCategory(String categoryName, int count) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Opening $categoryName category"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
