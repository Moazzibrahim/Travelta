import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/view/Auth/forget_password_screen.dart'; // Import for SVG

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-Left Decorative Image
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              'assets/images/vector.svg', // Replace with your image path
              width: 150,
              height: 150,
            ),
          ),
          // Bottom-Right Decorative Image
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/images/vectors.svg', // Replace with your image path
              width: 150,
              height: 150,
            ),
          ),
          // Main Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50), // Add spacing for safe area
                  // Back Button and Login Title
                  const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  // Welcome Back Text
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Log In To Your Account",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  // Email TextField
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: mainColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password TextField
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.visibility_off,
                          color: mainColor,
                        ),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: mainColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPasswordScreen()));
                      },
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                            color: mainColor,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Sign Up
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "I Don't Have An Account? ",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                                color: mainColor,
                                decoration: TextDecoration.underline),
                            // Add a tap gesture if necessary
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Skip
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Skip",
                        style: TextStyle(color: mainColor),
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
