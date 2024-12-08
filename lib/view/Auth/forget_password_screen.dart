import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/view/Auth/otp_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Forgot Password?",
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Envelope Icon/Image
            Center(
              child: SvgPicture.asset(
                "assets/images/forgetpass.svg", // Replace with your SVG file path
                height: 150,
                width: 150,
              ),
            ),
            const SizedBox(height: 30),
            // Forgot Password Text
            const Text(
              "Forgot Password ?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please Enter Your Email To Reset The Password",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            // Email/Phone Input Field
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Phone Or Email",
                hintStyle:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: mainColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Reset Password Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Add your reset password logic here
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OTPVerificationScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
