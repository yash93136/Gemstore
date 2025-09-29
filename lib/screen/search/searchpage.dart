import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/newfile.dart';
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
    {"image": AppImages.Products1, "title": "Denim Jacket", "price": 60.0},
    {"image": AppImages.Products2, "title": "Black Shoes", "price": 55.0},
    {"image": AppImages.Products3, "title": "Summer Top", "price": 25.0},
  ];
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = [];

  void _addSearch(String query) {
    if (query.isNotEmpty && !recentSearches.contains(query)) {
      setState(() {
        recentSearches.insert(0, query);
      });
    }
    _searchController.clear();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Keys.endDrawreKey,
      appBar: AppBar(
        actions: [SizedBox()],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price'),
              RangeSlider(
                values: _priceRange,
                min: 10,
                max: 80,
                divisions: 7,
                labels: RangeLabels(
                  '\$${_priceRange.start.round()}',
                  '\$${_priceRange.end.round()}',
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _priceRange = values;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Color Options
              const Text('Color'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  CircleAvatar(backgroundColor: Colors.orange),
                  SizedBox(width: 8),
                  CircleAvatar(backgroundColor: Colors.red),
                  SizedBox(width: 8),
                  CircleAvatar(backgroundColor: Colors.blue),
                  SizedBox(width: 8),
                  CircleAvatar(backgroundColor: Colors.black),
                  SizedBox(width: 8),
                  CircleAvatar(backgroundColor: Colors.white),
                  SizedBox(width: 8),
                  CircleAvatar(backgroundColor: Colors.pink),
                ],
              ),
              const SizedBox(height: 16),

              // Star Rating
              const Text('Star Rating'),
              Row(
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      color: index < _rating ? Colors.amber : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1.0;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              const Text('Category'),
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
                        child: Text(value),
                      );
                    })
                    .toList(),
              ),
              const SizedBox(height: 16),

              // Discount Options
              const Text('Discount'),
              Wrap(
                spacing: 8,
                children: List.generate(4, (index) {
                  List<String> discounts = [
                    '50% off',
                    '40% off',
                    '30% off',
                    '25% off',
                  ];
                  return ChoiceChip(
                    label: Text(discounts[index]),
                    selected: _discounts[index],
                    onSelected: (bool selected) {
                      setState(() {
                        _discounts[index] = selected;
                      });
                    },
                  );
                }),
              ),
              const Spacer(),

              // Apply Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        // Reset values
                        _priceRange = const RangeValues(10, 80);
                        _rating = 5;
                        _category = 'Crop Tops';
                        _discounts = [false, false, false, false];
                      });
                    },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Apply filter logic here
                      Navigator.pop(context); // drawer band karna
                    },
                    child: const Text('Apply'),
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
