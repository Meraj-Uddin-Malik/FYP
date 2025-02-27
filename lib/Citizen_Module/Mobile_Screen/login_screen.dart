import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'forgot_pass_screen.dart';
import 'signup_screen.dart';
import 'dart:async';


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
  final _formKey = GlobalKey<FormState>(); // GlobalKey for FormState
  bool _isPasswordVisible = true;



  static const TextStyle textStyle = TextStyle(
    fontFamily: 'Barlow',
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );


  signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Attempt login with Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: cnicController.text, // Use the email entered in the form
          password: passwordController.text,
        );

        // Check if user is authenticated
        if (userCredential.user != null) {
          // Fetch user data from Firestore
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user?.uid)  // Using UID to get the user doc
              .get();

          if (userDoc.exists) {
            var userData = userDoc.data() as Map<String, dynamic>;
            String role = userData['role'];
            String badgeNo = userData['badgeno'] ?? '';  // Empty if no badge
            String username = userData['username'];
            String cnic = userData['cnic'];
            String email = userData['email'];
            String gender = userData['gender'];

            // Print user data for debugging purposes
            print('User Role: $role');
            print('Badge No: $badgeNo');
            print('Username: $username');
            print('CNIC: $cnic');
            print('Email: $email');
            print('Gender: $gender');

            // Check for valid role and navigate accordingly
            if (role == null || role.isEmpty) {
              showErrorAlert('Role not found for the user.');
            } else {
              // Check if role and badgeNo are valid for admin or police
              if (role.toLowerCase() == 'admin' || role.toLowerCase() == 'police') {
                if (badgeNo.isEmpty) {
                  showErrorAlert('Badge number is required for $role.');
                } else {
                  switch (role.toLowerCase()) {
                    case 'admin':
                      navigateToAdminScreen();
                      break;
                    case 'police':
                      navigateToPoliceScreen(badgeNo);  // Only for police, badge is checked
                      break;
                    default:
                      showErrorAlert('Invalid Role: $role');
                      break;
                  }
                }
              }
              // For Citizen: No badge check, just role-based navigation
              else if (role.toLowerCase() == 'citizen') {
                navigateToCitizenScreen();
              } else {
                showErrorAlert('Invalid Role: $role');
              }
            }
          } else {
            showErrorAlert('User data not found');
          }
        } else {
          showErrorAlert('Authentication Failed');
        }
      } catch (e) {
        // Handle any errors (e.g., invalid credentials)
        ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Login Failed",
            text: "Incorrect credentials. Please try again.",
          ),
        );
      }
    } else {
      // Show validation error if form is not valid
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.warning,
          title: "Validation Error",
          text: "Please fill in all fields correctly.",
        ),
      );
    }
  }


  navigateToAdminScreen() {
    print('Navigating to Admin Screen'); // Debugging
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.success,
        title: "Login Successful",
        text: "You are logged in as Admin.",
      ),
    );
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/admin_main_screen');
    });
  }

  navigateToPoliceScreen(String badgeNo) {
    print('Navigating to Police Screen');
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.success,
        title: "Login Successful",
        text: "You are logged in as Police. Badge No: $badgeNo",
      ),
    );
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/police_main_screen');
    });
  }

  navigateToCitizenScreen() {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.success,
        title: "Login Successful",
        text: "You are logged in as Citizen.",
      ),
    );
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/citizen_main_screen');
    });
  }

  showErrorAlert(String message) {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.danger,
        title: "Error",
        text: message,
      ),
    );
  }



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
                        child: Form(
                          key: _formKey, // Add Form widget
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
                              _buildTextField(cnicController, 'Enter your email', false, Icons.email, true),
                              const SizedBox(height: 15),
                              _buildTextField(passwordController, 'Enter your password', true, Icons.lock, false),
                              const SizedBox(height: 15),
                              if (selectedToggleIndex != 0)
                                _buildTextField(badgeNoController, 'Enter your Badge no', false, Icons.badge, false),
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
      IconData icon,
      bool isEmail) {
    return SizedBox(
      width: 300.0,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText && !_isPasswordVisible,
        style: const TextStyle(
          color: Color(0xFF203982), // Blue text for user input
          fontSize: 14.0,
        ),
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text, // Email validation
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(color: const Color(0xFF203982).withOpacity(0.7), fontSize: 13.0),
          floatingLabelStyle: const TextStyle(color: Color(0xFF203982), fontWeight: FontWeight.w400, fontSize: 17.5),
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          prefixIcon: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [Color(0xFF203982), Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Icon(icon, color: Colors.red.shade100, size: 19.5),
          ),
          suffixIcon: (labelText == 'Enter your password' || labelText == 'Confirm your password')
              ? IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
            borderSide: BorderSide(color: Color(0xFF203982), width: 0.6),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF203982), width: 1.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          if (isEmail && !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
      ),
    );
  }

}
