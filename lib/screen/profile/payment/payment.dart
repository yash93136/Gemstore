import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/screen/profile/payment/addcard.dart'; // Make sure this path is correct
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

class Paymant extends StatefulWidget {
  const Paymant ({Key? key}) : super(key: key);

  @override
  State<Paymant> createState() => _Checkout2State();
}

class _Checkout2State extends State<Paymant> {
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  

  double productPrice = 99.99;
  double subtotal = 99.99;
  bool agreeToTerms = true; 
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
          }, onSave: (CardModel) {  },
        ),
      ),
    );
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPaymentIcon(AppImages.paypal, 'PayPal'),
                  _buildPaymentIcon(AppImages.vish, 'Visa'),
                  _buildPaymentIcon(AppImages.mastercar, 'Mastercard'),
                  _buildPaymentIcon(AppImages.alipay, 'Alipay'),
                  _buildPaymentIcon(AppImages.amex, 'Amex'),
                ],
              ),
            ),
          
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (agreeToTerms) {
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
  Color buttonBackgroundColor; // Declare here, assign dynamically

  switch (label) {
    case 'PayPal':
      buttonBackgroundColor = const Color.fromARGB(255, 255, 255, 255); // PayPal's primary blue
      break;
    case 'Visa':
      buttonBackgroundColor = const Color.fromARGB(255, 255, 255, 255); // Visa's primary dark blue
      break;
    case 'Mastercard':
      buttonBackgroundColor = const Color.fromARGB(255, 255, 255, 255); // Mastercard's primary red
      break;
    case 'Alipay':
      buttonBackgroundColor = const Color.fromARGB(255, 255, 255, 255); // Alipay's primary blue
      break;
    case 'Amex':
      buttonBackgroundColor = const Color(0xFF2671B6); // Amex's primary blue
      break;
    default:
      buttonBackgroundColor = Colors.white; // Fallback color
  }

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
        color: buttonBackgroundColor, // Use the dynamically assigned color
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
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}
}