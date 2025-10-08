import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart'; // Assuming this path is correct
import 'package:gemstore/screen/yourcart.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final List<Map<String, dynamic>> productall = [
    {"image": AppImages.popular1, "title": "Long Sleeve Dress", "price": 45.0},
    {"image": AppImages.popular2, "title": "Sportwear Set", "price": 80.0},
    {"image": AppImages.products3, "title": "White Sweater", "price": 35.0},
    {"image": AppImages.products1, "title": "Denim Jacket", "price": 60.0},
    {"image": AppImages.products2, "title": "Black Shoes", "price": 55.0},
    {"image": AppImages.products3, "title": "Summer Top", "price": 25.0},
    {"image": AppImages.popular3, "title": "Kimi Green Dress", "price": 47.99},
    {"image": AppImages.filtedWaistDress, "title": "Filted Waist Dress", "price": 60.0},
    {"image": AppImages.frontTieMiniDress, "title": "Front Tie Mini Dress", "price": 59.00},
    {"image": AppImages.leavesGreenDress, "title": "Leaves Green Dress", "price": 64.0},
    {"image": AppImages.linenDress, "title": "Linen Dress", "price": 52.00},
    {"image": AppImages.offShoulderDress, "title": "Off Shoulder Dress", "price": 78.00},
    {"image": AppImages.oharaDress, "title": "Ohara Dress", "price": 85.00},
    {"image": AppImages.tieBackMiniDress, "title": "Tie Back Mini Dress", "price": 67.00},
  ];

  ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedColorIndex = 0;
  int selectedSizeIndex = 2; // Assuming L is default selected, as in the new image
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // No longer using Stack for the whole screen, as FAB will be handled by Scaffold.
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.45, // Slightly reduced height
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      widget.product["image"],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3, // Assuming 3 dots as before
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: index == 0 ? Colors.black : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.only(left: 16, top: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16, top: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product["title"],
                            style: GoogleFonts.ptSans(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Text(
                            "\$${widget.product["price"]}",
                            style: GoogleFonts.ptSans(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Product Rating (using a simple 5-star display as per image)
                      Row(
                        children: [
                          _buildStarRating(4), // Assuming a default 4-star rating here, adjust if actual rating is available
                          const SizedBox(width: 8),
                          Text(
                            "4/5", // Static text for now, match your data if available
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Color and Size Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Color Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Color",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18, color: Colors.grey[500]),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  _buildColorOption(Colors.brown[200]!, 0),
                                  const SizedBox(width: 12),
                                  _buildColorOption(Colors.black, 1),
                                  const SizedBox(width: 12),
                                  _buildColorOption(Colors.red[300]!, 2),
                                ],
                              ),
                            ],
                          ),

                          // Size Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Size",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18,  color: Colors.grey[500]),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  _buildSizeOption("S", 0),
                                  const SizedBox(width: 12),
                                  _buildSizeOption("M", 1),
                                  const SizedBox(width: 12),
                                  _buildSizeOption("L", 2),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // ... inside your build method, find the description section ...

                      const Text(
                        "Description",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ExpandableText(
                        text: "Sportswear is no longer under culture, it is no longer indie or cobbled together as it once was. Sport is fashion today. This is just a longer example text to demonstrate the 'Read more' functionality. Imagine a very detailed product description that goes on for several lines. You wouldn't want to overwhelm the user immediately with all that text.",
                        trimLines: 3, // Display up to 3 lines initially
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                        linkStyle: const TextStyle(
                          color: Colors.blue, // A distinct color for "Read more"
                          fontWeight: FontWeight.bold,
                        ),
                        readMoreText: 'Read more',
                        readLessText: 'Read less',
                      ),
                      const SizedBox(height: 10),
                      
                      MyProductDetailsScreen(),
                      const SizedBox(height: 20),

                      // Review cards
                      _buildReviewCard(
                        "Jennifer Rose",
                        AppImages.apple, // Use appropriate image
                        5,
                        "I love it. Awesome customer service!! Highly recommend to everyone!",
                      ),
                      const SizedBox(height: 12),
                      _buildReviewCard(
                        "Kelly Rihana",
                        AppImages.facebook, // Use appropriate image
                        4,
                        "Delivered on time, good quality. Worth the price.",
                      ),
                      const SizedBox(height: 20),

                      // Similar Products section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Similar Product", // Changed from Feature Products
                              style: GoogleFonts.ptSans(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
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
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.productall.length,
                          itemBuilder: (context, index) {
                            final product = widget.productall[index];
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
                      const SizedBox(height: 80), // Added space for the FloatingActionButton
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Floating Action Button for Add to Cart
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const YourCart()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Background color
            foregroundColor: Colors.white, // Text and icon color
            minimumSize: const Size(double.infinity, 50), // Full width
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Curved corners
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            elevation: 6, // Shadow effect
          ),
          icon: const Icon(Icons.shopping_bag_outlined, size: 24),
          label: const Text(
            "Add To Cart",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // Helper for displaying star rating in a row
  Widget _buildStarRating(int rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star,
          size: 16,
          color: index < rating ? Colors.amber : Colors.grey[300],
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color, int index) {
    bool isSelected = selectedColorIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColorIndex = index;
        });
      },
      child: Container(
        width: 38, // Slightly smaller
        height: 38, // Slightly smaller
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent, // White border
            width: 4, // Thicker border
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
       
      ),
    );
  }

  Widget _buildSizeOption(String size, int index) {
    bool isSelected = selectedSizeIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSizeIndex = index;
        });
      },
      child: Container(
        width: 45, // Adjusted width
        height: 45, // Adjusted height
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey[200], // Black if selected
          border: Border.all(
            color: Colors.grey.shade300, // Subtle grey border even when not selected
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600], // Black text if not selected
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildReviewCard(String name, String imagePath, int rating, String review) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(imagePath),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 14,
                          color: index < rating ? Colors.amber : Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}


class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines; // Number of lines to show before trimming
  final TextStyle? textStyle;
  final TextStyle? linkStyle;
  final String readMoreText;
  final String readLessText;

  const ExpandableText({
    super.key,
    required this.text,
    this.trimLines = 3, // Default to 3 lines
    this.textStyle,
    this.linkStyle,
    this.readMoreText = 'Read more',
    this.readLessText = 'Read less',
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  late TextPainter _textPainter;

  @override
  void initState() {
    super.initState();
    _textPainter = TextPainter(
      textDirection: TextDirection.ltr, // Assuming LTR for most cases
    );
  }

  // Helper to determine if the text overflows
  bool _isTextOverflown(String text, TextStyle? style, int maxLines, double maxWidth) {
    _textPainter.text = TextSpan(text: text, style: style);
    _textPainter.maxLines = maxLines;
    _textPainter.layout(maxWidth: maxWidth);
    return _textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme.of(context).textTheme.bodyMedium;
    final textStyle = widget.textStyle ?? defaultTextStyle?.copyWith(
      fontSize: 14,
      color: Colors.grey[600],
      height: 1.5,
    );
    final linkStyle = widget.linkStyle ?? textStyle?.copyWith(color: Colors.blue); // Default link color

    // We need to calculate if the text overflows *after* the widget has rendered and has a maxWidth
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!_isTextOverflown(widget.text, textStyle, widget.trimLines, constraints.maxWidth)) {
          // If text does not overflow, just display it fully.
          return Text(
            widget.text,
            style: textStyle,
          );
        } else {
          // If text overflows, display expandable version
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.text,
                style: textStyle,
                maxLines: _isExpanded ? null : widget.trimLines,
                overflow: TextOverflow.fade, // Use fade for a smoother truncation
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _isExpanded ? widget.readLessText : widget.readMoreText,
                    style: linkStyle,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class MyProductDetailsScreen extends StatelessWidget {
  const MyProductDetailsScreen({super.key});

  Widget _buildRatingBar(int starCount, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            "$starCount",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.grey, size: 14), // Har individual rating ke aage grey star
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green[700]!),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "${(percentage * 100).toInt()}%",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Helper function for 5 overall stars
  // In the new image, these are always full, not half.
  Widget _buildOverallStarsAlwaysFull() {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      stars.add(Icon(Icons.star, color: Colors.green[700], size: 18)); // Always full green stars
    }
    return Row(mainAxisSize: MainAxisSize.min, children: stars); // Use MainAxisSize.min for a tight fit
  }

  @override
  Widget build(BuildContext context) {
    // Overall rating value
    final double overallRating = 4.9;
    final int totalRatings = 83;

    return Padding(
      padding: const EdgeInsets.all(16.0), // Add some padding around the whole section
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Left align content within this column
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Reviews",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
            ],
          ),
          const SizedBox(height: 16),

          // Top rating summary section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Align to top for 'OUT OF 5' placement
            children: [
              // 4.9 and OUT OF 5
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        overallRating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4), // Small space
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0), // Adjust position of "OUT OF 5"
                        child: Text(
                          "OUT OF 5",
                          style: TextStyle(
                            fontSize: 12, // Smaller font for "OUT OF 5"
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(), // Pushes the stars and ratings to the far right

              // 5 stars and 83 ratings
              Column(
                crossAxisAlignment: CrossAxisAlignment.end, // Right align content in this column
                children: [
                  _buildOverallStarsAlwaysFull(), // 5 full stars
                  const SizedBox(height: 4), // Space between stars and rating count
                  Text(
                    "$totalRatings ratings", // Dynamic total ratings
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10), // Space between top summary and rating bars

          // Individual rating bars
          Column(
            children: [
              _buildRatingBar(5, 0.80),
              _buildRatingBar(4, 0.12),
              _buildRatingBar(3, 0.05),
              _buildRatingBar(2, 0.03),
              _buildRatingBar(1, 0.00),
            ],
          ),
        ],
      ),
    );
  }
}