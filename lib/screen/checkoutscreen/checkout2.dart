import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/screen/addcard.dart'; // Make sure this path is correct
import 'package:gemstore/screen/checkoutscreen/checkout3.dart';

class CardModel {
  final String cardNumber;
  final String cardHolderName;
  final String validThru;
  final String cardType;
  final Color cardColor;
  final String cvv;

  CardModel({
    required this.cardNumber,
    required this.cardHolderName,
    required this.validThru,
    required this.cardType,
    required this.cardColor,
    this.cvv = 'XXX',
  });

  // Helper for copying and updating a card
  CardModel copyWith({
    String? cardNumber,
    String? cardHolderName,
    String? validThru,
    String? cardType,
    Color? cardColor,
    String? cvv,
  }) {
    return CardModel(
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      validThru: validThru ?? this.validThru,
      cardType: cardType ?? this.cardType,
      cardColor: cardColor ?? this.cardColor,
      cvv: cvv ?? this.cvv,
    );
  }
}

class Checkout2 extends StatefulWidget {
  const Checkout2({Key? key}) : super(key: key);

  @override
  State<Checkout2> createState() => _Checkout2State();
}

class _Checkout2State extends State<Checkout2> {
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  String _selectedPaymentMethod = 'Credit Card';

  double productPrice = 99.99;
  double subtotal = 99.99;
  bool _agreeToTerms = true; // Renamed _copyAddress for clarity

  final List<CardModel> _cards = [
    CardModel(
      cardNumber: '4364 1345 8932 8378',
      cardHolderName: 'Smithe Pham',
      validThru: '03/24',
      cardType: 'Visa',
      cardColor: const Color(0xFF4A9EE6),
      cvv: '123',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToAddEditCard({CardModel? existingCard, int? cardIndex}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewCardScreen(
          existingCard: existingCard,
          cardIndex: cardIndex,
          onCardAdded: (updatedCard, index) {
            setState(() {
              if (index == null) {
                // Add new card
                _cards.add(updatedCard);
                // Animate to the new card
                Future.delayed(const Duration(milliseconds: 100), () {
                  _pageController.animateToPage(
                    _cards.length - 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              } else {
                // Update existing card
                _cards[index] = updatedCard;
              }
            });
          }, onSave: (CardModel p1) {  },
        ),
      ),
    );

    // If result is true, it means a card was successfully added/updated,
    // and the onCardAdded callback should have handled the state update.
    // We can potentially refresh the current page to ensure everything is in sync.
    if (result == true) {
      setState(() {
        // Just rebuild the widget to reflect any changes if necessary
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 0, top: 16),
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
                  ),
                  const Center(
                    child: Text(
                      'Check out',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, color: Colors.black, size: 30),
                const SizedBox(width: 4),
                Row(
                  children: List.generate(
                    5,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Icon(Icons.credit_card, color: Colors.black, size: 30),
                const SizedBox(width: 20),
                Row(
                  children: List.generate(
                    5,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.check_circle_rounded, color: Colors.grey[400], size: 30),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STEP 2',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Payment',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPaymentTab('Cash', Icons.money),
                  _buildPaymentTab('Credit Card', Icons.credit_card),
                  _buildPaymentTab("Other", Icons.more_horiz),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Choose your card',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _navigateToAddEditCard(), // Navigate to add a new card
                    child: const Text(
                      'Add new+',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: screenHeight * .250,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _cards.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _navigateToAddEditCard(
                        existingCard: _cards[index], cardIndex: index),
                    child: _buildCreditCard(_cards[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _cards.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.blue
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'or check out with',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPaymentIcon(AppImages.paypal, 'PayPal'),
                  _buildPaymentIcon(AppImages.vish, 'Visa'),
                  _buildPaymentIcon(AppImages.mastercar, 'Mastercard'),
                  _buildPaymentIcon(AppImages.alipay, 'Alipay'),
                  _buildPaymentIcon(AppImages.amex, 'Amex'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildPriceSummary(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'I agree to Terms and conditions',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                value: _agreeToTerms,
                onChanged: (bool? newValue) {
                  setState(() {
                    _agreeToTerms = newValue!;
                  });
                },
                activeColor: Colors.green,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_agreeToTerms) {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  Checkout3()));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please agree to terms and conditions.')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Place my order',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceSummary() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              const Text(
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
              const Text(
                "Subtotal",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${subtotal.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTab(String title, IconData icon) {
    bool isSelected = _selectedPaymentMethod == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = title;
        });
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2D3142) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[700],
              size: 40,
            ),
            if (title.isNotEmpty)
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditCard(CardModel card) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  // You might want to display a small card logo here based on card.cardType
                ),
              ),
              Text(
                card.cardType,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            card.cardNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CARDHOLDER NAME',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.cardHolderName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VALID THRU',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.validThru,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentIcon(String asset, String label) {
    Color buttonBackgroundColor = Colors.white;

    return GestureDetector(
      onTap: () {
        int index = _cards.indexWhere((card) => card.cardType == label);

        if (index != -1) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          String cardType = label;
          Color cardColor;

          switch (label) {
            case 'PayPal':
              cardColor = const Color(0xFF003087);
              break;
            case 'Visa':
              cardColor = const Color(0xFF1A1F71);
              break;
            case 'Mastercard':
              cardColor = const Color(0xFFEB001B);
              break;
            case 'Alipay':
              cardColor = const Color(0xFF00A0E9);
              break;
            case 'Amex':
              cardColor = const Color(0xFF2671B6);
              break;
            default:
              cardColor = Colors.grey;
          }

          setState(() {
            _cards.add(
              CardModel(
                cardNumber: '0000 0000 0000 0000',
                cardHolderName: 'Card Holder Name',
                validThru: 'MM/YY',
                cvv: 'XXX',
                cardType: cardType,
                cardColor: cardColor,
              ),
            );
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            _pageController.animateToPage(
              _cards.length - 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        }
      },
      child: Container(
        width: 50,
        height: 40,
        decoration: BoxDecoration(
          color: buttonBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            asset,
            fit: BoxFit.contain, // Changed to contain to avoid cropping issues
          ),
        ),
      ),
    );
  }
}