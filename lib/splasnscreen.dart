import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/modal/uihelper.dart' show uihelper;
import 'package:gemstore/login_singin/sing_up.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  SizedBox(height: 440),
                  uihelper.CustomText(
                    text: "Welcome to GemStore! ",
                    color: Colors.white,
                    fontweight: FontWeight.bold,
                    height: 30,
                  ),
                  SizedBox(height: 10),
                  uihelper.CustomText(
                    text: " The home for a fashionista",
                    color: Colors.white,
                    fontweight: FontWeight.bold,
                    height: 18,
                  ),
                  SizedBox(height: 60),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        29.5,
                      ), // border-radius: 29.5px
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ), // blur(10px)
                        child: Container(
                          width: 193,
                          height: 53,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 53,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                              0.25,
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 1.18, // 1.18px border
                            ),
                            borderRadius: BorderRadius.circular(29.5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Get Sterted',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ptSans(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                height: 1.41,
                                letterSpacing: 0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
