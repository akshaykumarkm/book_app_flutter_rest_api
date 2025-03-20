import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<dynamic> _books = [];

  bool get isLoading => _isLoading;
  List<dynamic> get books => _books;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<String?> getTkn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

  Future<void> getBooks() async {
    const String url =
        "https://book-management-backend-jydw.onrender.com/books/getbooks";

    String? token = await getTkn();
    if (token == null) {
      print("No token");
      return;
    }

    try {
      setLoading(true);
      final res = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        _books = jsonDecode(res.body);
      } else {
        print("Error: ${res.statusCode}, ${res.body}");
      }
    } catch (e) {
      print("Request failed: $e");
    } finally {
      setLoading(false);
    }
  }
}
