import 'package:flutter/material.dart';
import 'package:gemstore/main.dart';
import 'package:gemstore/screen/home/homepage.dart';
import 'package:gemstore/screen/myorders/myorders.dart';
import 'package:gemstore/screen/search/discover.dart';
import 'package:provider/provider.dart'; // Import provider for ThemeManager

// Assuming ThemeManager is defined as in main.dart or theme_manager.dart
// class ThemeManager extends ChangeNotifier { ... } // If not in a separate file

class CustomDrawer extends StatelessWidget {
  final String currentPage;

  const CustomDrawer({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    // ThemeManager को सुनें
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // User Info Section (Same as before)
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.pink.shade100,
                  child: const Icon(Icons.person, color: Colors.pink),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sunie Pham',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'sunieux@gmail.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Menu Items (Same as before, just ensure currentPage is passed)
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.home_outlined,
                  text: 'Homepage',
                  pageName: 'Homepage',
                  currentPage: currentPage,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.search,
                  text: 'Discover',
                  pageName: 'Discover',
                  currentPage: currentPage,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Discover()),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.shopping_bag_outlined,
                  text: 'My Order',
                  pageName: 'My Order',
                  currentPage: currentPage,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyOrdersPage()),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person_outline,
                  text: 'My profile',
                  pageName: 'My profile',
                  currentPage: currentPage,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyOrdersPage()),
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Text(
                    'OTHER',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings_outlined,
                  text: 'Setting',
                  pageName: 'Setting',
                  currentPage: currentPage,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyOrdersPage()),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.mail_outline,
                  text: 'Support',
                  pageName: 'Support',
                  currentPage: currentPage,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyOrdersPage()),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.info_outline,
                  text: 'About us',
                  pageName: 'About us',
                  currentPage: currentPage,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyOrdersPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          // Light/Dark Mode Toggle
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Consumer<ThemeManager>( // Use Consumer to rebuild this part when theme changes
              builder: (context, manager, child) {
                bool isLightMode = manager.themeMode == ThemeMode.light;
                bool isDarkMode = manager.themeMode == ThemeMode.dark;

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            manager.toggleTheme(false); // Set to light mode
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: isLightMode
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: isLightMode
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.wb_sunny_outlined,
                                    color: isLightMode ? Colors.black : Colors.grey),
                                const SizedBox(width: 5),
                                Text('Light',
                                    style: TextStyle(
                                        color: isLightMode ? Colors.black : Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            manager.toggleTheme(true); // Set to dark mode
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: isDarkMode
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.mode_night_outlined,
                                    color: isDarkMode ? Colors.black : Colors.grey),
                                const SizedBox(width: 5),
                                Text('Dark',
                                    style: TextStyle(
                                        color: isDarkMode ? Colors.black : Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required String pageName,
    required String currentPage,
    VoidCallback? onTap,
  }) {
    bool isSelected = pageName == currentPage;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: isSelected
          ? BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            )
          : null,
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade700,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          onTap?.call();
        },
      ),
    );
  }
}