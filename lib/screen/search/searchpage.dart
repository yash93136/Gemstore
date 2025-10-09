import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/screen/product.dart';
import 'package:gemstore/screen/search/Discover.dart';
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
    {"image": AppImages.filtedWaistDress, "title": "Filted Waist Dress", "price": 60.0},
    {"image": AppImages.frontTieMiniDress, "title": "Front Tie Mini Dress", "price": 59.00},
    {"image": AppImages.leavesGreenDress, "title": "Leaves Green Dress", "price": 64.0},
    {"image": AppImages.linenDress, "title": "Linen Dress", "price": 52.00},
    {"image": AppImages.offShoulderDress, "title": "Off Shoulder Dress", "price": 78.00},
    {"image": AppImages.oharaDress, "title": "Ohara Dress", "price": 85.00},
    {"image": AppImages.tieBackMiniDress, "title": "Tie Back Mini Dress", "price": 67.00},
  ];
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = [];
  List<String> suggestions = [];
  OverlayEntry? _overlayEntry;

  void _addSearch(String query) {
    if (query.isNotEmpty && !recentSearches.contains(query)) {
      setState(() {
        recentSearches.insert(0, query);
      });
      
      // Filter products based on search query
      final searchResults = products
          .where((product) => 
              product["title"].toLowerCase().contains(query.toLowerCase()))
          .toList();
      
      // Navigate to ProductListScreen with search results
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductListScreen(
            searchQuery: query,
            products: searchResults,
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

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Keys.searchEndDrawreKey,
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
                      Keys.searchEndDrawreKey.currentState?.openEndDrawer();
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductListScreen(
                          searchQuery: "All Products",
                          products: products,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Show all",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: products.isEmpty
                  ? Center(child: Text("No products found"))
                  : ListView.builder(
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
                                            ProductDetailScreen(
                                          product: product,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    product["image"],
                                    height: 180,
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

// Product List Screen with Grid View
class ProductListScreen extends StatefulWidget {
  final String searchQuery;
  final List<Map<String, dynamic>> products;

  const ProductListScreen({
    Key? key,
    required this.searchQuery,
    required this.products,
  }) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<bool> favorites = [];

  @override
  void initState() {
    super.initState();
    favorites = List.generate(widget.products.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Keys.searchEndDrawreKey2,
      backgroundColor: Colors.grey[50],
      endDrawer: Drawer2(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.searchQuery,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Found\n${widget.products.length} Results',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Keys.searchEndDrawreKey2.currentState?.openEndDrawer();
                  },
                  icon: const Text(
                    'Filter',
                    style: TextStyle(color: Colors.black),
                  ),
                  label: const Icon(
                    Icons.filter_list,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.products.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: widget.products.length,
                    itemBuilder: (context, index) {
                      final product = widget.products[index];
                      return ProductCard(
                        product: product,
                        isFavorite: favorites[index],
                        onFavoriteToggle: () {
                          setState(() {
                            favorites[index] = !favorites[index];
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ProductCard({
    Key? key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: InkWell(
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
                    child: Image.asset(
                      product["image"],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product["title"],
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product["price"].toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < 4 ? Icons.star : Icons.star_border,
                      size: 14,
                      color: Colors.amber,
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// Sample DressScreen
class DressScreen extends StatelessWidget {
  final List<Map<String, dynamic>> dressData;

  const DressScreen({required this.dressData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dresses")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dresses",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: dressData.isEmpty
                  ? Center(child: Text("No dresses found"))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: dressData.length,
                      itemBuilder: (context, index) {
                        final product = dressData[index];
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
                                         ProductDetailScreen(product: product,),
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

// Sample ProductDetailScreen

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
 final List<Color> _colors = [
    Colors.orange.shade900,
    Colors.redAccent,
    Colors.black,
     Colors.blueAccent,
    Colors.grey,
    Colors.brown,
    Colors.purpleAccent
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
        padding: const EdgeInsets.all(25.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 40), // Reduced spacing

             
              const Text(
                'Price',
                style: TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.w600,
                ),
              ),
              SliderTheme(
                data: SliderThemeData(
                  thumbColor: Colors.white,
                 
                  activeTrackColor: Colors.black
                ),
                child: RangeSlider(
                  values: _priceRange,
                  min: 10,
                  max: 100,
                  divisions: 9,
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
              ),
              const SizedBox(height: 8), // Reduced spacing
              const Text(
                'Color',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15),
              Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                children: List.generate(_colors.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColors[index] = !_selectedColors[index];
                      });
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: _colors[index],
                      foregroundColor:
                          _colors[index] == Colors.black ? Colors.white : null,
                      child: _selectedColors[index]
                          ? const Icon(Icons.check, size: 18)
                          : null,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Star Rating
              const Text(
                'Star Rating',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
               const SizedBox(height: 15),
              Row(
                
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
              const SizedBox(height: 20),

              // Category Dropdown
           const Text(
          'Category',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButton<String>(
            value: _category,
            isExpanded: true,
            hint: const Text('Select a category'),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.blueAccent,
              size: 24,
            ),
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _category = newValue;
                });
              }
            },
            items: <String>['Crop Tops', 'T-Shirts', 'Jeans', 'Jackets']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                  Image.asset(
                 _getCategoryIcon(value),
                   width: 20,
                   height: 20,
                  color: Colors.blueAccent, // Optional: tint the image
    ),
                    const SizedBox(width: 8),
                    Text(
                      value,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
               SizedBox(height: 12),

              // Discount Options (Improved Styling, 2 per row)
              const Text(
                'Discount',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
                  const SizedBox(height: 15),
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
                      selectedColor: Colors.grey,
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
                              ? Colors.black87
                              : Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const Spacer(),
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
                      Navigator.pop(context); 
                    },
                  child:
                  Text(
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

String _getCategoryIcon(String category) {
  switch (category) {
    case 'Crop Tops':
      return AppImages.croptops;
    case 'T-Shirts':
      return AppImages.tshirt;
    case 'Jeans':
      return AppImages.jeans;
    case 'Jackets':
      return AppImages.jackets;
    default:
      return AppImages.collection;
  }
}
