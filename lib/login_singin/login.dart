import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/screen/home/homepage.dart';
import 'package:gemstore/login_singin/sing_up.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.05),
            Text(
              "Log into",
              style: GoogleFonts.ptSans(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
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
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                  letterSpacing: 0,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email address",
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: screenHeight * 0.03),
            TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Password",
                border: const UnderlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Implement forgot password
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Center(
              child: SizedBox(
                width: screenWidth * 0.4,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 67, 48, 41),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.5),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    String email = emailController.text.trim();
                    String password = passwordController.text;

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Please enter both email and password"),
                        ),
                      );
                      return;
                    }

                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  HomePage()),
                    );
                  },
                  child: const Text(
                    "LOG IN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            const Center(child: Text("or log in with")),
            SizedBox(height: screenHeight * 0.06),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialLoginButton(AppImages.apple),
                SizedBox(width: screenWidth * 0.05),
                _socialLoginButton(AppImages.google),
                SizedBox(width: screenWidth * 0.05),
                _socialLoginButton(AppImages.facebook),
              ],
            ),
            SizedBox(height: screenHeight * 0.09),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign Up",
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

  Widget _socialLoginButton(String assetPath) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
        },
        icon: Image.asset(assetPath, height: 30, width: 30),
        splashRadius: 24,
      ),
    );
  }
}
