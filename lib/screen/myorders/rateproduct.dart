import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/screen/myorders/order2.dart';

class RateProductScreen extends StatefulWidget {
  @override
  _RateProductScreenState createState() => _RateProductScreenState();
}

class _RateProductScreenState extends State<RateProductScreen> {
  int _selectedRating = 0;
  TextEditingController  reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
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
                      ],
                    ),
                    const Center(
                      child: Text(
                        'Rate Product',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
            _buildSubmitReviewBanner(),
            SizedBox(height: 24.0),
            _buildStarRating(),
            SizedBox(height: 24.0),
            _buildReviewInput(),
            SizedBox(height: 24.0),
            _buildImageUploadSection(),
            Spacer(),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitReviewBanner() {
    return SizedBox(
      height: 80,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(Icons.card_giftcard, color: Colors.white,size: 40,),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'Submit your review to get 5 points',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white,size: 30,),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _selectedRating ? Icons.star : Icons.star_border,
            color: Colors.teal,
            size: 40.0,
          ),
          onPressed: () {
            setState(() {
              _selectedRating = index + 1;
            });
          },
        );
      }),
    );
  }

  Widget _buildReviewInput() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: reviewController,
              maxLines: 9,
              decoration: InputDecoration(
                hintText: 'Would you like to write anything about this product?',
                border: InputBorder.none,
              ),
              onChanged: (text) {
                setState(() {}); // To update character count
              },
            ),
            Text(
              '${reviewController.text.length} characters',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Row(
      children: [
        Image.asset(
            AppImages.photoicon,
            width: 60,
            height: 60,
            fit: BoxFit.fill,
           ),
        SizedBox(width: 16.0),
        Image.asset(
            AppImages.cameraicon,
            width: 60,
            height: 60,
            fit: BoxFit.fill,
           )
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails2Screen()));
         },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black, // Button color
        padding: EdgeInsets.symmetric(vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Text(
        'Submit Review',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }
}

