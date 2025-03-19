import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "Akshay Kumar",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                HomeBookCardWidget(),
                HomeBookCardWidget(),
                HomeBookCardWidget(),
              ],
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
        onPressed: () {},
        elevation: 0,
        isExtended: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class HomeBookCardWidget extends StatelessWidget {
  const HomeBookCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/book");
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
              "Note Book",
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text("By Nicholas Sparks"),
          ],
        ),
      ),
    );
  }
}
