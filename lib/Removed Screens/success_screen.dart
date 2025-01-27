import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_project/Citizen_Module/Mobile_Screen/otp_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Setting the system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF2A489E),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF2A489E),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 118.0),
              child: Center(
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.red,
                  size: 90.0,
                ),
              ),
            ),

            const SizedBox(height: 25.0),
            const Text(
              'SUCCESS !',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Barlow',
                fontWeight: FontWeight.w700,
                height: 1.5, // Adjusted for better spacing
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'We have send a 4 digit verification \ncode to your phone',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Barlow',
                height: 1.5, // Adjusted for better spacing
                letterSpacing: 1.60,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 245.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OtpScreen()), // later put OPT Code Screen. its just for texting.
                ),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
