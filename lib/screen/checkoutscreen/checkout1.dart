import 'package:flutter/material.dart';


class Checkout1Screen extends StatefulWidget {
  const Checkout1Screen({super.key});

  @override
  State<Checkout1Screen> createState() => _CheckoutShippingScreenState();
}

class _CheckoutShippingScreenState extends State<Checkout1Screen> {

   int? selectedShippingMethod;
  bool _copyAddress = true;

  // Controllers for text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateProvinceController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _couponCodeController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _countryController.dispose();
    _streetNameController.dispose();
    _cityController.dispose();
    _stateProvinceController.dispose();
    _zipCodeController.dispose();
    _phoneNumberController.dispose();
    _couponCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( 
           child: SingleChildScrollView(
          child: Column   ( 
            children: [
             Padding(
  padding: const EdgeInsets.all(16.0),
  child: Stack(
    alignment: Alignment.center,
    children: [
      Row(
        children: [
        Container(
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
        ],
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

            
            
 Row(
  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: Colors.black, size: 30),
                        const SizedBox(width: 4),
                        Row(
                          children: List.generate(
                            5, // Number of dots
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
                        const SizedBox(width: 20 ),
                        Icon(Icons.credit_card, color: Colors.grey[400], size: 30),
                        const SizedBox(width: 20 ),
                         Row(
                          children: List.generate(
                            5, // Number of dots
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
                    SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(16.0), // Main content padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'STEP 1',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Shipping',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 24),

                    // Shipping Address Form
                    _buildTextField(
                      controller: _firstNameController,
                      labelText: 'First name *',
                      hintText: '', 
                      ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _lastNameController,
                      labelText: 'Last name *',
                      hintText: '',
                     
                    ),
                    const SizedBox(height: 16),
                   DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Country*',
                
                  suffixIcon: Icon(Icons.arrow_drop_down_sharp)
                ),
                items: ['USA', 'Canada', 'IND']
                    .map((country) => DropdownMenuItem(
                          value: country,
                          child: Text(country),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _streetNameController,
                      labelText: 'Street name *',
                      hintText: '',
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _cityController,
                      labelText: 'City *',
                      hintText: '',
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _stateProvinceController,
                      labelText: 'State / Province',
                      hintText: '',
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _zipCodeController,
                      labelText: 'Zip-code *',
                      hintText: '',
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _phoneNumberController,
                      labelText: 'Phone number *',
                      hintText: '',
                    ),
                    const SizedBox(height: 25),
                      
                    // Shipping Method
                    const Text(
                      'Shipping method',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       ShippingOption(
                         value: 0,
                         groupValue: selectedShippingMethod,
                         onChanged: (int? newValue) {
                           setState(() {
                             selectedShippingMethod = newValue ;
                           });
                         },
                         title: 'Delivery to home',
                         subtitle: 'Delivery from 3 to 7 business days',
                         price: 'Free',
                         freePriceColor: Colors.teal, // Custom color for 'Free'
                         titleColor: Colors.black, // Custom color for 'Delivery to home'
                       ),
                       SizedBox(height: 16),
                       ShippingOption(
                         value: 1,
                         groupValue: selectedShippingMethod,
                         onChanged: (int? newValue) {
                           setState(() {
                             selectedShippingMethod = newValue ;
                           });
                         },
                         title: 'Delivery to home',
                         subtitle: 'Delivery from 4 to 6 business days',
                         price: '\$9.90',
                       ),
                       SizedBox(height: 16),
                       ShippingOption(
                         value: 2,
                         groupValue: selectedShippingMethod,
                         onChanged: (int? newValue) {
                           setState(() {
                             selectedShippingMethod = newValue;
                           });
                         },
                         title: 'Fast Delivery',
                         subtitle: 'Delivery from 2 to 3 business days',
                         price: '\$9.90',
                       ),
                     ],
                   ),
                    const SizedBox(height: 32),

                    // Coupon Code
                    const Text(
                      'Coupon Code',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _couponCodeController,
                              decoration: InputDecoration(
                                hintText: 'Have a code? Type it here...',
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                hintStyle: TextStyle(color: Colors.grey[500]),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle validate coupon
                            },
                            child: const Text(
                              'Validate',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Billing Address
                    const Text(
                      'Billing Address',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Copy address data from shipping',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      value: _copyAddress,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _copyAddress = newValue!;
                        });
                      },
                      activeColor: Colors.grey,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                   ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Handle continue to payment
          
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Continue to payment',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    String? errorText,
    Color? errorColor,
    IconData? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            labelStyle: TextStyle(
                color: errorText != null ? errorColor : Colors.grey[600]),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green[700]!),
            ),
            errorText: errorText, // Display error text
            errorStyle: TextStyle(color: errorColor),
          ),
        ),
        if (errorText != null && errorColor == null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
 
}
class ShippingOption extends StatelessWidget {
  final int value;
  final int? groupValue;
  final ValueChanged<int?> onChanged;
  final String title;
  final String subtitle;
  final String price;
  final Color? freePriceColor; // New parameter for 'Free' color
  final Color? titleColor; // New parameter for title color

  const ShippingOption({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    required this.subtitle,
    required this.price,
    this.freePriceColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white38,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: RadioListTile<int>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: Colors.teal, // You can change this color
        title: Row(
          children: [
            if (price == 'Free') // Show 'Free' with custom color
              Text(
                price,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: freePriceColor ?? Colors.black, // Default to green if not provided
                ),
              ),
            if (price != 'Free') // Show price only if it's not 'Free'
              Text(
                price,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: price == 'Free' ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
                color: titleColor ?? Colors.black, // Default to black if not provided
              ),
            ),
          ],
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
