// ignore_for_file: use_build_context_synchronously

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'forgot_pass_screen.dart';
import 'signup_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  int? selectedToggleIndex = 0;
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController badgeNoController = TextEditingController();
  bool _isPasswordVisible = true;

  signIn() async {
    // print("Email: ${cnicController.text}");
    // print("Password: ${passwordController.text}");

    if (cnicController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: cnicController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/citizen_main_screen');
    } catch (e) {
      // print("Login Failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  static const TextStyle textStyle = TextStyle(
    fontFamily: 'Barlow',
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF2A489E),
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ));

    return Scaffold(
      backgroundColor: const Color(0xFF2A489E),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(radius: 65.0,
                    backgroundImage: AssetImage('images/Police.png')),
                const SizedBox(height: 4.0),
                Text('Welcome Back', style: textStyle.copyWith(
                    fontSize: 18.0, color: Colors.white)),
                Text('Login',
                    style: textStyle.copyWith(color: const Color(0xFFE22128))),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 40.0,),
                            const Padding(
                              padding: EdgeInsets.only(right: 195.0),
                              child: Text('Select Users:',
                                  style: TextStyle(color: Color(0xFF2A489E))),
                            ),
                            ToggleSwitch(
                              initialLabelIndex: selectedToggleIndex,
                              totalSwitches: 3,
                              labels: const ['CITIZEN', 'ADMIN', 'POLICE'],
                              cornerRadius: 20.0,
                              minHeight: 35.5,
                              minWidth: 100.0,
                              fontSize: 13.0,
                              activeFgColor: Colors.white,
                              inactiveFgColor: const Color(0xFF2A489E),
                              activeBgColor: const [Colors.red],
                              inactiveBgColor: Colors.transparent,
                              borderColor: const [Color(0xFF2A489E)],
                              borderWidth: 0.9,
                              onToggle: (index) =>
                                  setState(() => selectedToggleIndex = index),
                            ),
                            const SizedBox(height: 30),
                            _buildTextField(cnicController,
                                'Enter your ID Number', false, Icons.credit_card),
                            const SizedBox(height: 15),
                            _buildTextField(passwordController,
                                'Enter your password', true, Icons.phone),
                            const SizedBox(height: 15),
                            if (selectedToggleIndex != 0)
                              _buildTextField(
                                  badgeNoController, 'Enter your Badge no', false,
                                  Icons.badge),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (
                                              context) => const ForgotPassScreen()),
                                        ),
                                    child: const Text(
                                      'Forget Password?',
                                      style: TextStyle(color: Color(0xFF2A489E),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 245.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () => signIn(),
                                child: const Text('Sign In'),
                              ),
                            ),
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (
                                        context) => const SignUpScreen()),
                                  ),
                              child: RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: const TextStyle(
                                      color: Color(0xFF2A489E), fontSize: 14.0),
                                  children: [
                                    TextSpan(
                                      text: 'Sign up.',
                                      style: TextStyle(
                                        color: const Color(0xFF2A489E)
                                            .withOpacity(0.8),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String labelText,
      bool obscureText,
      IconData icon) {
    return SizedBox(
      width: 300.0,
      child: TextField(
        controller: controller,
        obscureText: obscureText && !_isPasswordVisible,
        style: const TextStyle(
          color: Color(0xFF203982), // Blue text for user input
          fontSize: 14.0,
        ),
        keyboardType: labelText == 'Enter your CNIC'
            ? TextInputType.number
            : TextInputType.text, // Set keyboard type based on label
        inputFormatters: labelText == 'Enter your CNIC'
            ? [
          FilteringTextInputFormatter.digitsOnly, // Only digits
          LengthLimitingTextInputFormatter(13), // Max 13 digits
          TextInputFormatter.withFunction((oldValue, newValue) {
            // CNIC formatter logic
            String digits = newValue.text.replaceAll(RegExp(r'\D'), '');
            String formatted = '';
            if (digits.length <= 5) {
              formatted = digits; // First 5 digits
            } else if (digits.length <= 12) {
              formatted =
              '${digits.substring(0, 5)}-${digits.substring(5)}'; // Add first hyphen
            } else {
              formatted =
              '${digits.substring(0, 5)}-${digits.substring(5, 12)}-${digits.substring(12)}'; // Add second hyphen
            }
            return TextEditingValue(
              text: formatted,
              selection:
              TextSelection.collapsed(offset: formatted.length),
            );
          }),
        ]
            : [], // Empty formatter for non-CNIC fields
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(
            color: const Color(0xFF203982).withOpacity(0.7),
            fontSize: 13.0,
          ),
          floatingLabelStyle: const TextStyle(
            color: Color(0xFF203982),
            fontWeight: FontWeight.w400,
            fontSize: 17.5,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0,
          ),
          prefixIcon: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [Color(0xFF203982), Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Icon(
              icon,
              color: Colors.red.shade100, // Base icon color
              size: 19.5,
            ),
          ),
          suffixIcon: (labelText == 'Enter your password' ||
              labelText == 'Confirm your password')
              ? IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: const Color(0xFF203982),
            ),
            iconSize: 19.0,
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )
              : null,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF203982),
              width: 0.6,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF203982),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
