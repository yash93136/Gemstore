import 'package:flutter/material.dart';
import 'package:gemstore/log_in.dart';

class SignUpScreen extends StatelessWidget {
  final VoidCallback toggleTheme;
  const SignUpScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: toggleTheme,
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.08,
          vertical: size.height * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text(
              "your account",
              style: TextStyle(fontSize: 22, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            TextField(
              decoration: const InputDecoration(labelText: "Enter your name"),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(labelText: "Email address"),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: "Confirm password"),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(toggleTheme: () {}),
                    ),
                  );
                },
                child: const Text("SIGN UP"),
              ),
            ),
            const SizedBox(height: 25),

            const Center(child: Text("or sign up with")),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialButton(Icons.apple, Colors.black),
                const SizedBox(width: 15),
                _socialButton(Icons.g_mobiledata, Colors.red),
                const SizedBox(width: 15),
                _socialButton(Icons.facebook, Colors.blue),
              ],
            ),
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have account? "),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, '/'),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, Color color) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey[300],
      child: Icon(icon, color: color, size: 28),
    );
  }
}
