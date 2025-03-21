import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateProvider with ChangeNotifier {
  TextEditingController dateController = TextEditingController();

  DateProvider() {
    dateController.text = DateFormat("dd MMM yyyy").format(DateTime.now());
  }

  String get selectedDate => dateController.text;

  void updateDate(DateTime date) {
    dateController.text = DateFormat("dd MMM yyyy").format(date);
    notifyListeners();
  }

  void updateDateFromText(String dateText) {
    try {
      DateTime parsedDate = DateFormat("dd MMM yyyy").parse(dateText);
      updateDate(parsedDate);
    } catch (e) {
      print("Invalid date");
    }
  }
}
