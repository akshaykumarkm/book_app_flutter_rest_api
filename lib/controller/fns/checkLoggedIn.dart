import 'package:book_app/controller/providers/auth_provider.dart';
import 'package:flutter/material.dart';

Future<void> checkLoggedIn(BuildContext context) async {
  final authProvider = AuthProvider();
  await authProvider.getTkn();
  if (authProvider.token == null) {
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    }
  }
}
