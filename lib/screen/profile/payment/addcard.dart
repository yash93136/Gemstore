import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart'; // Make sure this path is correct
import 'package:gemstore/screen/checkoutscreen/checkout2.dart'; // Import to use CardModel

class AddNewCardScreen extends StatefulWidget {
  final CardModel? cardToEdit; // Pass a card if editing, null if adding new
  final Function(CardModel) onSave; // Callback to save/update the card

  const AddNewCardScreen({
    Key? key,
    this.cardToEdit,
    required this.onSave, CardModel? existingCard, int? cardIndex, required Null Function(dynamic updatedCard, dynamic index) onCardAdded,
  }) : super(key: key);

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  late TextEditingController _cardHolderNameController;
  late TextEditingController _cardNumberController;
  late TextEditingController _validThruController;
  late TextEditingController _cvvController;

  @override
  void initState() {
    super.initState();
    _cardHolderNameController = TextEditingController(text: widget.cardToEdit?.cardHolderName ?? '');
    _cardNumberController = TextEditingController(text: widget.cardToEdit?.cardNumber ?? '');
    _validThruController = TextEditingController(text: widget.cardToEdit?.validThru ?? '');
    _cvvController = TextEditingController(text: widget.cardToEdit?.cvv ?? '');
  }

  @override
  void dispose() {
    _cardHolderNameController.dispose();
    _cardNumberController.dispose();
    _validThruController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: Text(
          widget.cardToEdit == null ? 'Add new card' : 'Edit card',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Widget Preview
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 200,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF9900), Color(0xFFFFCC00)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Abstract circles/shapes for design
                    Positioned(
                      top: -20,
                      left: -20,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 100,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                     Positioned(
                      bottom: -30,
                      right: -30,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                    ),

                    // Card content
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Image.asset(
                              AppImages.mastercardiogo, // Assume this is a Mastercard logo
                              height: 40,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(4, (index) => _buildStarRow()),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'CARDHOLDER NAME',
                                    style: TextStyle(color: Colors.white70, fontSize: 10),
                                  ),
                                  Text(
                                    _cardHolderNameController.text.toUpperCase().isEmpty
                                        ? 'CARD HOLDER NAME'
                                        : _cardHolderNameController.text.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'VALID THRU',
                                    style: TextStyle(color: Colors.white70, fontSize: 10),
                                  ),
                                  Text(
                                    _validThruController.text.isEmpty
                                        ? 'MM/YY'
                                        : _validThruController.text,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Form fields
            Text(
              'Cardholder Name',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            TextField(
              controller: _cardHolderNameController,
              decoration: const InputDecoration(
                hintText: 'Sunie Pham',
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              onChanged: (text) {
                setState(() {}); // To update the card preview
              },
            ),
            const SizedBox(height: 20),

            Text(
              'Card Number',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '5412363272837284',
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              onChanged: (text) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expires',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      TextField(
                        controller: _validThruController,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          hintText: '03/23',
                          hintStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                        onChanged: (text) {
                          setState(() {}); // To update the card preview
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CVV',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      TextField(
                        controller: _cvvController,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        maxLength: 3, // Typically 3 digits for CVV
                        decoration: const InputDecoration(
                          hintText: '999',
                          hintStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Add card button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_cardNumberController.text.isNotEmpty &&
                      _cardHolderNameController.text.isNotEmpty &&
                      _validThruController.text.isNotEmpty &&
                      _cvvController.text.isNotEmpty) {
                    CardModel newOrUpdatedCard = CardModel(
                      cardNumber: _cardNumberController.text,
                      cardHolderName: _cardHolderNameController.text,
                      validThru: _validThruController.text,
                      cvv: _cvvController.text,
                      cardType: widget.cardToEdit?.cardType ?? 'Unknown', // Preserve type if editing, else default
                      cardColor: widget.cardToEdit?.cardColor ?? Colors.blueAccent, // Preserve color if editing, else default
                    );
                    widget.onSave(newOrUpdatedCard); // Call the callback
                    Navigator.pop(context); // Go back after saving
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all card details.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  widget.cardToEdit == null ? 'Add card' : 'Save card',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRow() {
    return Row(
      children: List.generate(
        4,
        (index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 1),
          child: Icon(Icons.star, color: Colors.white, size: 8),
        ),
      ),
    );
  }
}