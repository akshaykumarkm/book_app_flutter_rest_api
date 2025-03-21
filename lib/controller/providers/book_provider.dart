import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  Future<void> addBook(
    String title,
    String author,
    int pages,
    String language,
    String publisher,
    String date,
    BuildContext context,
  ) async {
    const String url =
        "https://book-management-backend-jydw.onrender.com/books/createbooks";

    String? token = await getTkn();
    if (token == null) {
      print("No token");
      return;
    }

    try {
      setLoading(true);

      final res = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "title": title,
          "author": author,
          "publishedDate": date,
          "pages": pages,
          "language": language,
          "publisher": publisher,
        }),
      );

      final responseData = jsonDecode(res.body);
      if (res.statusCode == 201) {
        print("Book added successfully: ${responseData["message"]}");
        Fluttertoast.showToast(
          msg: "Book added successfully: ${responseData["message"]}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        }
        setLoading(false);
      } else {
        print("Error: ${res.statusCode}, ${res.body}");
      }
    } catch (e) {
      print("Request failed: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> editBook(
    String id,
    String title,
    String author,
    int pages,
    String language,
    String publisher,
    String date,
    BuildContext context,
  ) async {
    final String url =
        "https://book-management-backend-jydw.onrender.com/books/updatebooks/$id";

    String? token = await getTkn();
    if (token == null) {
      print("No token");
      return;
    }

    try {
      setLoading(true);

      final res = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "title": title,
          "author": author,
          "publishedDate": date,
          "pages": pages,
          "language": language,
          "publisher": publisher,
        }),
      );

      final responseData = jsonDecode(res.body);
      if (res.statusCode == 200) {
        print("Book edited successfully: ${responseData["message"]}");
        Fluttertoast.showToast(
          msg: "Book edited successfully: ${responseData["message"]}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        }
        setLoading(false);
      } else {
        print("Error: ${res.statusCode}, ${res.body}");
      }
    } catch (e) {
      print("Request failed: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteBook(String id, BuildContext context) async {
    final String url =
        "https://book-management-backend-jydw.onrender.com/books/deletebooks/$id";

    String? token = await getTkn();
    if (token == null) {
      print("No token");
      return;
    }

    try {
      setLoading(true);

      final res = await http.delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final responseData = jsonDecode(res.body);
      if (res.statusCode == 200) {
        print("Book deleted successfully: ${responseData["message"]}");
        Fluttertoast.showToast(
          msg: "Book deleted successfully: ${responseData["message"]}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        }
        setLoading(false);
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
