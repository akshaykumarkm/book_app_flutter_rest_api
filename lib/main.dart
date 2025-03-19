import 'package:book_app/view/screens/book_details/book_details.dart';
import 'package:book_app/view/screens/home/home_screen.dart';
import 'package:book_app/view/screens/login/login_screen.dart';
import 'package:book_app/view/screens/signup/signup_screen.dart';
import 'package:book_app/view/screens/splash/splash_screen.dart';
import 'package:book_app/view/themes/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book App',
      theme: mainTheme,
      initialRoute: "/",
      routes: {
        "/splash": (context) => SplashScreen(),
        "/": (context) => HomeScreen(),
        "/book": (context) => BookDetails(),
        "/login": (context) => LoginScreen(),
        "/signup": (context) => SignupScreen(),
      },
    );
  }
}
