import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/newfile.dart';
import 'package:gemstore/screen/search/Discover.dart';
import 'package:gemstore/searchresultsscreen.dart';
import 'package:gemstore/utils/kyes.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, dynamic>> products = [
    {"image": AppImages.popular1, "title": "Lihua Tunic White", "price": 51.0},
    {"image": AppImages.popular2, "title": "Skirt Dress", "price": 34.0},
    {"image": AppImages.popular3, "title": "Kimi Green Dress", "price": 47.99},
    {"image": AppImages.popular1, "title": "Denim Jacket", "price": 60.0},
    {"image": AppImages.products2, "title": "Black Shoes", "price": 55.0},
    {"image": AppImages.products3, "title": "Summer Top", "price": 25.0},
  ];
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = [];
  List<String> suggestions = [];
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.contains("dress")) {
        suggestions = products
            .where((product) => product["title"].toLowerCase().contains("dress"))
            .map((product) => product["title"] as String)
            .toList();
      } else {
        suggestions = [];
      }
      _showOverlay(context);
    });
  }

  void _addSearch(String query) {
    if (query.isNotEmpty && !recentSearches.contains(query) && query.toLowerCase().contains("dress")) {
      setState(() {
        recentSearches.insert(0, query);
      });
      // Filter products for "Dress"
      List<Map<String, dynamic>> filteredProducts = products
          .where((product) => product["title"].toLowerCase().contains("dress"))
          .toList();
      // Navigate to DressScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DressScreen(
            query: query,
            filteredProducts: filteredProducts,
          ),
        ),
      );
      _searchController.clear();
      _removeOverlay();
    }
  }

  void _removeSearch(String query) {
    setState(() {
      recentSearches.remove(query);
    });
  }

  void _clearAllSearches() {
    setState(() {
      recentSearches.clear();
    });
  }

  void _showOverlay(BuildContext context) {
    _removeOverlay();
    if (suggestions.isNotEmpty && _searchController.text.toLowerCase().contains("dress")) {
      _overlayEntry = _createOverlayEntry(context);
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx + 16,
        top: offset.dy + 50 + 16, // Adjust based on search bar height
        width: size.width - 80, // Adjust for padding and filter icon
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions[index]),
                  onTap: () {
                    _searchController.text = suggestions[index];
                    _addSearch(suggestions[index]);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Keys.endDrawreKey,
      appBar: AppBar(
        actions: [SizedBox()],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Discover(),
              ),
            );
          },
          icon: Icon(Icons.chevron_left),
        ),
      ),
      endDrawer: Drawer2(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
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
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onSubmitted: _addSearch,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
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
              ],
            ),
            SizedBox(height: 50),
            if (recentSearches.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Searches",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: _clearAllSearches,
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20),
            if (recentSearches.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 15.0,
                  runSpacing: 20.0,
                  children: recentSearches.map((search) {
                    return Chip(
                      label: Text(search),
                      deleteIcon: Icon(Icons.close),
                      onDeleted: () => _removeSearch(search),
                    );
                  }).toList(),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Popular this week",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Show all clicked!")),
                    );
                  },
                  child: const Text(
                    "Show all",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 250,
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
                              height: 200,
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
          ],
        ),
      ),
    );
  }
}
class Drawer2 extends StatefulWidget {
  const Drawer2({super.key});

  @override
  State<Drawer2> createState() => _Drawer2State();
}

class _Drawer2State extends State<Drawer2> {
  RangeValues _priceRange = const RangeValues(10, 80);
  double _rating = 5;
  String _category = 'Crop Tops';
  List<bool> _discounts = [false, false, false, false];
  List<Color> _colors = [
    Colors.orange,
    Colors.red,
    Colors.blue,
    Colors.black,
    Colors.white,
    Colors.pink,
  ];
  late List<bool> _selectedColors;

  @override
  void initState() {
    super.initState();
    _selectedColors = List<bool>.filled(_colors.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter Header with Icon on Right
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.filter_list),
                ],
              ),
              const SizedBox(height: 12), // Reduced spacing

              // Price Range (Smaller)
              const Text(
                'Price',
                style: TextStyle(
                  fontSize: 14, // Smaller font size
                  fontWeight: FontWeight.w600,
                ),
              ),
              RangeSlider(
                values: _priceRange,
                min: 10,
                max: 80,
                divisions: 7,
                labels: RangeLabels(
                  '\$${_priceRange.start.round()}',
                  '\$${_priceRange.end.round()}',
                ),
                activeColor: Colors.blueAccent, // Added for better visibility
                inactiveColor: Colors.grey[300],
                onChanged: (RangeValues values) {
                  setState(() {
                    _priceRange = values;
                  });
                },
              ),
              const SizedBox(height: 8), // Reduced spacing

              // Color Options (Using Wrap to prevent overflow)
              const Text(
                'Color',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(_colors.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColors[index] = !_selectedColors[index];
                      });
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: _colors[index],
                      foregroundColor:
                          _colors[index] == Colors.white ? Colors.black : null,
                      child: _selectedColors[index]
                          ? const Icon(Icons.check, size: 18)
                          : null,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),

              // Star Rating
              const Text(
                'Star Rating',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: index < _rating ? Colors.amber : Colors.grey,
                      size: 28, // Slightly smaller
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1.0;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 12),

              // Category Dropdown
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DropdownButton<String>(
                value: _category,
                onChanged: (String? newValue) {
                  setState(() {
                    _category = newValue!;
                  });
                },
                items: <String>['Crop Tops', 'T-Shirts', 'Jeans', 'Jackets']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(fontSize: 14)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              // Discount Options (Improved Styling, 2 per row)
              const Text(
                'Discount',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: List.generate(4, (index) {
                  List<String> discounts = [
                    '50% off',
                    '40% off',
                    '30% off',
                    '25% off',
                  ];
                  return SizedBox(
                    width:
                        (MediaQuery.of(context).size.width - 44) / 2, // 2 per row
                    child: ChoiceChip(
                      label: Text(
                        discounts[index],
                        style: TextStyle(
                          color: _discounts[index]
                              ? Colors.white
                              : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      selected: _discounts[index],
                      selectedColor: Colors.blueAccent,
                      backgroundColor: Colors.grey[200],
                      elevation: _discounts[index] ? 4 : 1,
                      pressElevation: 8,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      onSelected: (bool selected) {
                        setState(() {
                          _discounts[index] = selected;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: _discounts[index]
                              ? Colors.blueAccent
                              : Colors.grey[400]!,
                          width: 1,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const Spacer(),

              // Reset and Apply Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _priceRange = const RangeValues(10, 80);
                        _rating = 5;
                        _category = 'Crop Tops';
                        _discounts = [false, false, false, false];
                        _selectedColors = List<bool>.filled(_colors.length, false);
                      });
                    },
                    child: const Text(
                      'Reset',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the drawer
                    },
                    child:  Text(
                      'Apply',
                      style: TextStyle(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}