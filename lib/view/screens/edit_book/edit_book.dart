import 'package:book_app/controller/providers/book_provider.dart';
import 'package:book_app/controller/providers/date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditBook extends StatelessWidget {
  const EditBook({super.key, required this.book});

  final Map<String, dynamic> book;

  @override
  Widget build(BuildContext context) {
    print(book);
    final dateProvider = context.read<DateProvider>();
    final bookProvider = Provider.of<BookProvider>(context);

    final page = book["pages"].toString();

    final GlobalKey<FormState> editBookKey = GlobalKey<FormState>();

    final TextEditingController titleController = TextEditingController(
      text: book["title"],
    );
    final TextEditingController authorController = TextEditingController(
      text: book["author"],
    );
    final TextEditingController pagesController = TextEditingController(
      text: page,
    );
    final TextEditingController languageController = TextEditingController(
      text: book["language"],
    );
    final TextEditingController publisherController = TextEditingController(
      text: book["publisher"],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Book"),
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
                  key: editBookKey,
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
                                initialDate: DateTime.parse(
                                  book["publishedDate"],
                                ),
                                firstDate: DateTime(1800),
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
                                if (editBookKey.currentState!.validate()) {
                                  bookProvider.editBook(
                                    book["id"].toString(),
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
                              child: Text("Edit Book"),
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
