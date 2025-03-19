import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _initializeApp(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    _initializeApp(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image(
              image: AssetImage("lib/view/assets/icons/book_logo.png"),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "BOOK APP",
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
