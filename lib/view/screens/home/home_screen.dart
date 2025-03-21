import 'package:book_app/controller/fns/checkLoggedIn.dart';
import 'package:book_app/controller/providers/auth_provider.dart';
import 'package:book_app/controller/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

int getYearFromDate(String date) {
  return DateTime.parse(date).year;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    checkLoggedIn(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BOOK APP",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder(
              future: bookProvider.getBooks(),
              builder:
                  (context, snapshot) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await authProvider.logOut(context);
                            },
                            icon: Icon(
                              Icons.logout_outlined,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      ),

                      Divider(color: Colors.deepOrange),
                      SizedBox(height: 30),
                      Text(
                        "Browse All Books",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Consumer<BookProvider>(
                        builder: (context, booksProv, child) {
                          return bookProvider.books.isEmpty
                              ? Center(child: Text("No Books added yet!"))
                              : ListView.builder(
                                itemCount: booksProv.books.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final book = bookProvider.books[index];
                                  return HomeBookCardWidget(book: book);
                                },
                              );
                        },
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepOrange,
        label: Text(
          "Add New Book",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pushNamed(context, "/add_book");
        },
        elevation: 2,
        isExtended: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class HomeBookCardWidget extends StatelessWidget {
  const HomeBookCardWidget({super.key, this.book});

  final dynamic book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/book", arguments: book);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.deepOrange.withAlpha(30),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${book["title"]} (${getYearFromDate(book["publishedDate"])})",
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text("By ${book["author"]}"),
          ],
        ),
      ),
    );
  }
}
