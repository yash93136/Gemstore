import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/login_singin/login.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
   double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight* 0.05),
            Text(
              "Create",
              style: GoogleFonts.ptSans(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 28,
                              
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                            ),
            ),
            Text(
              "your account",
              style: GoogleFonts.ptSans(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 28,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                            ),   
                              ),
             SizedBox(height: screenHeight*0.05,),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Enter your name",
                border: UnderlineInputBorder(),
              ),
            ),
             SizedBox(height: screenHeight*0.02,),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email address",
                border: UnderlineInputBorder(),
              ),
            ),
             SizedBox(height: screenHeight*0.02,),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: UnderlineInputBorder(),
              ),
            ),
             SizedBox(height: screenHeight*0.02,),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm password",
                border: UnderlineInputBorder(),
              ),
            ),

             SizedBox(height: screenHeight*0.05,),
            Center(
              child: SizedBox(
                width: screenWidth*0.4
,                height: screenHeight*0.06,
                child: Opacity(
                  opacity: 1.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 60, 44, 38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),
            ),

             SizedBox(height: screenHeight*0.03),
             Center(child: Text("or sign up with")),
             SizedBox(height: screenHeight*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(AppImages.apple, height: 30, width: 30),
                    splashRadius: 24,
                  ),
                ),
                 SizedBox(width:screenWidth*0.05 ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(AppImages.google, height: 30, width: 30),
                    splashRadius: 24,
                  ),
                ),
                 SizedBox(width: screenWidth*0.05 ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      AppImages.facebook,
                      height: 30,
                      width: 30,
                    ),
                    splashRadius: 24,
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight*0.03,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Log In",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
