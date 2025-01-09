import 'package:flutter/material.dart';
import 'package:fyp_project/Citizen_Module/Mobile_Screen/update_password_screen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  static const Color backgroundColor = Color(0xFF2A489E);
  static const TextStyle evaluateButtonTextStyle = TextStyle(
    fontFamily: 'Barlow',
    fontWeight: FontWeight.w800,
    letterSpacing: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // Added background for better visibility
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add an icon at the top
             const Icon(
                Icons.email_sharp,  // You can change this icon to anything else
                size: 55.0,
                color: Colors.red,
              ),
              const SizedBox(height: 20.0),  // Add some spacing between icon and text

              const Text(
                'VERIFICATION CODE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Barlow',
                  fontWeight: FontWeight.w700,
                  height: 0,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'We have sent a 4 digit code\n to your email/phone',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Barlow',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 1.60,
                ),
              ),
              const SizedBox(height: 20.0),

              // code for circle text fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red, // Set the border color to red
                        width: 2.0, // Adjust the border width as needed
                      ),
                    ),
                    child: const TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20.0),
              RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: 'Didn’t receive any code? ',
                      style: TextStyle(
                          color: Colors.white, fontSize: 15, letterSpacing: 1)),
                  TextSpan(
                      text: 'Resend. ',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700)),
                ]),
              ),

              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const UpdatePasswordScreen()), // later put OPT Code Screen. its just for testing.
                ),
                child: const SizedBox(
                  width: 200.0,
                  child: Center(
                      child: Text('Confirm', style: evaluateButtonTextStyle)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
