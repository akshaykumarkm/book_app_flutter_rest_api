import 'package:book_app/controller/providers/auth_provider.dart';
import 'package:book_app/controller/providers/book_provider.dart';
import 'package:book_app/view/screens/book_details/book_details.dart';
import 'package:book_app/view/screens/home/home_screen.dart';
import 'package:book_app/view/screens/login/login_screen.dart';
import 'package:book_app/view/screens/signup/signup_screen.dart';
import 'package:book_app/view/screens/splash/splash_screen.dart';
import 'package:book_app/view/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => BookProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book App',
        theme: mainTheme,
        initialRoute: "/",
        routes: {
          "/splash": (context) => SplashScreen(),
          "/": (context) => HomeScreen(),
          // "/book": (context) => BookDetails(),
          "/login": (context) => LoginScreen(),
          "/signup": (context) => SignupScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == "/book") {
            final Map<String, dynamic> book =
                settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => BookDetails(book: book),
            );
          }
          return null;
        },
      ),
    );
  }
}
