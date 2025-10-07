import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/screen/home/homepage.dart';
import 'package:gemstore/screen/login_singin/sing_up.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Handles login logic with basic email/password check
 void _loginUser() {
  if (_formKey.currentState!.validate()) {
    // TEMP: Allow all valid logins
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.05),
              _titleText("Log into"),
              _titleText("your account"),
              SizedBox(height: screenHeight * 0.05),

              // Email Field
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email address",
                  border: UnderlineInputBorder(),
                ),
                validator: _validateEmail,
              ),
              SizedBox(height: screenHeight * 0.02),

              // Password Field
              TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const UnderlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: _validatePassword,
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              "Forgot Password functionality coming soon!")),
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Login Button
              Center(
                child: SizedBox(
                  width: screenWidth * 0.45,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 60, 44, 38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.5),
                      ),
                      elevation: 3,
                    ),
                    onPressed: _loginUser,
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

              SizedBox(height: screenHeight * 0.04),
              const Center(child: Text("or log in with")),
              SizedBox(height: screenHeight * 0.04),

              // Social login buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialLoginButton(AppImages.apple, screenWidth),
                  SizedBox(width: screenWidth * 0.05),
                  _socialLoginButton(AppImages.google, screenWidth),
                  SizedBox(width: screenWidth * 0.05),
                  _socialLoginButton(AppImages.facebook, screenWidth),
                ],
              ),

              SizedBox(height: screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Title text with consistent styling
  Widget _titleText(String text) {
    return Text(
      text,
      style: GoogleFonts.ptSans(
        textStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }

  /// Validates email field
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates password field
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  /// Returns circular social login button
  Widget _socialLoginButton(String assetPath, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Social login with ${assetPath.split('/').last.split('.').first} coming soon!",
              ),
            ),
          );
        },
        icon: Image.asset(assetPath, height: 30, width: 30),
        splashRadius: 24,
      ),
    );
  }
}
