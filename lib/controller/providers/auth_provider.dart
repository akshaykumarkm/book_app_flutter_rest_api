import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _token;

  bool get isLoading => _isLoading;
  String? get token => _token;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // sharef pref

  Future<void> saveTkn(String tokn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", tokn);
    _token = tokn;
    notifyListeners();
  }

  Future<void> getTkn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
    notifyListeners();
  }

  Future<void> logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    _token = null;
    notifyListeners();

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  // Sign Up

  Future<void> signUp(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    print("name : $name email $email pass $password");
    final url =
        "https://book-management-backend-jydw.onrender.com/users/signup";

    try {
      setLoading(true);
      final res = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );

      final responseData = jsonDecode(res.body);

      if (res.statusCode == 201 || res.statusCode == 200) {
        String token = responseData["token"];
        await saveTkn(token);
        print("User registered successfully: ${responseData["message"]}");
        Fluttertoast.showToast(
          msg: "User registered successfully: ${responseData["message"]}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        }
        setLoading(false);
        notifyListeners();
      } else {
        print("Somethig went wrong: ${responseData["message"]}");
        Fluttertoast.showToast(
          msg: "Somethig went wrong: ${responseData["message"]}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        setLoading(false);
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "Somethig went wrong: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      setLoading(false);
      notifyListeners();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    print("login called");
    const String url =
        "https://book-management-backend-jydw.onrender.com/users/login";

    try {
      setLoading(true);

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData.containsKey("token")) {
        String token = responseData["token"];
        await saveTkn(token);
        Fluttertoast.showToast(
          msg: "Login successful!",
          backgroundColor: Colors.green,
        );

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        }
      } else {
        Fluttertoast.showToast(
          msg: "Error: ${responseData["error"]}",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Request failed: $e",
        backgroundColor: Colors.red,
      );
    } finally {
      setLoading(false);
    }
  }
}
