import 'package:flutter/material.dart';
import 'package:fyp_project/Citizen_Module/Mobile_Screen/login_screen.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  static const Color backgroundColor = Color(0xFF2A489E);

  final TextEditingController cnicController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    cnicController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 65.0,
                  backgroundImage: AssetImage('images/Police.png'),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'UPDATE PASSWORD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Barlow',
                    fontWeight: FontWeight.w700,
                    height: 0,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Container(
                    width: 345,
                    height: 258,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 0.0),
                        _buildTextField(cnicController, 'Enter new password'),
                        const SizedBox(height: 15),
                        _buildTextField(passwordController, 'Confirm your password'),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 220.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            ),
                            child: const Text('Update Password'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return SizedBox(
      width: 300.0,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 15.0, color: Color(0xFF203982)),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF203982), width: 0.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF203982), width: 1.0),
          ),
        ),
      ),
    );
  }
}
