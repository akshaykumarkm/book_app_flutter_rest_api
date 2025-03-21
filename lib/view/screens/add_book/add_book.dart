import 'package:book_app/controller/providers/book_provider.dart';
import 'package:book_app/controller/providers/date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddBookScreen extends StatelessWidget {
  const AddBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dateProvider = context.read<DateProvider>();
    final bookProvider = Provider.of<BookProvider>(context);

    final GlobalKey<FormState> addBookKey = GlobalKey<FormState>();

    final TextEditingController titleController = TextEditingController();
    final TextEditingController authorController = TextEditingController();
    final TextEditingController pagesController = TextEditingController();
    final TextEditingController languageController = TextEditingController();
    final TextEditingController publisherController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Book"),
        foregroundColor: Colors.deepOrange,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Icon(
                    Icons.menu_book_outlined,
                    size: 50,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Form(
                  key: addBookKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Book Title";
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: "Title"),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: authorController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Book Author";
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: "Author"),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: pagesController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Book Total Pages";
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: "Total Pages"),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: languageController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Book Language";
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: "Language"),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: publisherController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Book Publisher Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: "Publisher"),
                      ),
                      SizedBox(height: 15),
                      Consumer<DateProvider>(
                        builder: (context, dateProvider, _) {
                          return TextFormField(
                            controller: dateProvider.dateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Book Published Date";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Published Date",
                              helperText: "Enter Book Published Date",
                              suffixIcon: Icon(Icons.calendar_today, size: 18),
                            ),
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );

                              if (pickedDate != null) {
                                dateProvider.updateDate(pickedDate);
                              }
                            },
                            onChanged: (text) {
                              dateProvider.updateDateFromText(text);
                            },
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      bookProvider.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (addBookKey.currentState!.validate()) {
                                  bookProvider.addBook(
                                    titleController.text.trim(),
                                    authorController.text.trim(),
                                    int.parse(pagesController.text.trim()),
                                    languageController.text.trim(),
                                    publisherController.text.trim(),
                                    dateProvider.selectedDate,
                                    context,
                                  );
                                }
                              },
                              child: Text("Add Book"),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
