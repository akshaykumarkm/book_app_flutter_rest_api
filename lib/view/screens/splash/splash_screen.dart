import 'package:book_app/controller/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _initializeApp(BuildContext context) async {
    final authProvider = AuthProvider();
    await authProvider.getTkn();
    await Future.delayed(const Duration(seconds: 4));
    if (context.mounted) {
      authProvider.token == null
          ? Navigator.pushReplacementNamed(context, "/login")
          : Navigator.pushReplacementNamed(context, "/");
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
