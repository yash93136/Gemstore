import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';


class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _stars = 0;
  TextEditingController _feedbackController = TextEditingController();
  bool _feedbackSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Share your feedback',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  'What is your opinion of GemStore?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _stars ? Icons.star : Icons.star_border,
                        color: index < _stars ? Colors.black : Colors.grey[400],
                        size: 45,
                      ),
                      onPressed: () {
                        setState(() {
                          _stars = index + 1;
                        });
                      },
                    );
                  }),
                ),
                SizedBox(height: 30),
                 Container(
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
              controller: _feedbackController,
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
              '${_feedbackController.text.length} characters',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    ),
              
                SizedBox(height: 20),
                Row(
                  children: [
                    _buildImagePlaceholder(),
                  
                  ],
                ),
                Spacer(),
                SizedBox(
                  width:300,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _feedbackSent = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Send feedback',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_feedbackSent)
            Container(
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.center,
              child: _buildThankYouCard(context),
            ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
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

  Widget _buildThankYouCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: Colors.green, size: 35),
            ),
            SizedBox(height: 20),
            Text(
              'Thank you for your feedback!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'We appreciated your feedback. We\'ll use your feedback to improve your experience.',
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            SizedBox(
              width:10,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _feedbackSent = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}