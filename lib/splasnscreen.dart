import 'package:flutter/material.dart';
import 'package:gemstore/intro.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/modal/uihelper.dart' show uihelper;

class Splasnscreen extends StatefulWidget {
  const Splasnscreen({super.key});

  @override
  State<Splasnscreen> createState() => _SplasnscreenState();
}

class _SplasnscreenState extends State<Splasnscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Image.asset(
              AppImages.welcomelogo,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 350),
                  uihelper.CustomText(
                    text: "Welcome to GemStore! ",
                    color: Colors.white,
                    fontweight: FontWeight.bold,
                    height: 30,
                  ),
                  uihelper.CustomText(
                    text: " The home for a fashionista",
                    color: Colors.white,
                    fontweight: FontWeight.bold,
                    height: 20,
                  ),
                  SizedBox(height: 100),
                  uihelper.Custombutton(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OnboardingScreen(),
                        ),
                      );
                    },
                    buttonName: "Get Started",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
