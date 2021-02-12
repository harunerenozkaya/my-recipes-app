import 'package:flutter/material.dart';

class AddNewRecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;
    final phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.orange,
        height: phoneHeight * 0.06,
      ),
      backgroundColor: Color.fromARGB(255, 252, 242, 249),
      appBar: AppBar(
        title: Text(
          "Add New Recipe",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 4, child: Container(color: Colors.green)),
            Expanded(flex: 6, child: Container(color: Colors.yellow)),
            Expanded(flex: 6, child: Container(color: Colors.blue)),
            Expanded(flex: 1, child: Container(color: Colors.purple)),
          ],
        ),
      ),
    );
  }
}
