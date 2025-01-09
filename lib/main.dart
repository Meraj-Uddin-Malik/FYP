import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Citizen_Module/Mobile_Screen/against_crime_screen.dart';
import 'Citizen_Module/Mobile_Screen/citizen_main_screen.dart';
import 'Citizen_Module/Mobile_Screen/login_screen.dart';
import 'Citizen_Module/Mobile_Screen/signup_screen.dart';
import 'Citizen_Module/Mobile_Screen/splash_screen.dart';
import 'Citizen_Module/Mobile_Screen/welcome_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      initialRoute: '/login_screen',  // Initial route set to SplashScreen
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome_screen': (context) => const LoginSignupSelection(),
        '/login_screen': (context) => const LoginPage(),
        '/signup_screen': (context) => const SignUpScreen(),
        '/citizen_main_screen': (context) =>  const CitizenMainScreen(),
        '/against_crime_screen': (context) =>  const AgainstCrimeScreen(),
      },
    );
  }
}
