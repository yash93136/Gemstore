// imports remain same
import 'package:flutter/material.dart';
import 'package:gemstore/modal/imagemodal.dart';
import 'package:gemstore/screen/login_singin/login.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  /// Handles user registration logic
  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match!")),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Successful! Please log in.")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // Ensure this is true to allow the body to resize when the keyboard appears
      resizeToAvoidBottomInset: true, 
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.05),
              _titleText("Create"),
              _titleText("your account"),
              SizedBox(height: screenHeight * 0.05),

              _inputField(nameController, "Enter your name", _validateName),
              SizedBox(height: screenHeight * 0.02),

              _inputField(emailController, "Email address", _validateEmail),
              SizedBox(height: screenHeight * 0.02),

              _passwordField(passwordController, "Password", _obscurePassword, () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              }, _validatePassword),
              SizedBox(height: screenHeight * 0.02),

              _passwordField(confirmPasswordController, "Confirm password", _obscureConfirmPassword, () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              }, _validateConfirmPassword),
              SizedBox(height: screenHeight * 0.05),

              // Sign Up Button
              Center(
                child: SizedBox(
                  width: screenWidth * 0.45,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 60, 44, 38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.5),
                      ),
                    ),
                    onPressed: _registerUser,
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              const Center(child: Text("or sign up with")),
              SizedBox(height: screenHeight * 0.04),

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
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
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

  Widget _titleText(String text) {
    return Text(
      text,
      style: GoogleFonts.ptSans(
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 28,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController controller, String label, String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, border: const UnderlineInputBorder()),
      validator: validator,
    );
  }

  Widget _passwordField(TextEditingController controller, String label, bool obscure, VoidCallback toggleVisibility, String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: const UnderlineInputBorder(),
        
      ),
      validator: validator,
    );
  }

  String? _validateName(String? value) =>
      (value == null || value.isEmpty) ? 'Please enter your name' : null;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

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