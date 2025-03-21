import 'package:book_app/controller/providers/auth_provider.dart';
import 'package:book_app/controller/providers/book_provider.dart';
import 'package:book_app/controller/providers/date_provider.dart';
import 'package:book_app/view/screens/add_book/add_book.dart';
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
        ChangeNotifierProvider(create: (context) => DateProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book App',
        theme: mainTheme,
        initialRoute: "/splash",
        routes: {
          "/splash": (context) => SplashScreen(),
          "/": (context) => HomeScreen(),
          "/add_book": (context) => AddBookScreen(),
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
