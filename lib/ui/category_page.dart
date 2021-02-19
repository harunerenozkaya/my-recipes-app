import 'package:flutter/material.dart';
import 'package:myRecipes/widgets/menu_drawer.dart';
import 'package:myRecipes/widgets/recipe_box.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;
  final String categoryId;

  CategoryPage(this.categoryName, this.categoryId);

  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;
    final phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: MenuDrawer(),
      backgroundColor: Color.fromARGB(255, 252, 242, 249),
      appBar: AppBar(
        title: Text(
          "My $categoryName Recipes",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "My Favorite $categoryName Recipes",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: phoneHeight * 0.01,
                    horizontal: phoneWidth * 0.015),
                color: Color.fromARGB(255, 235, 172, 215),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 0,
                  separatorBuilder: (context, index) => SizedBox(
                    width: phoneWidth * 0.02,
                  ),
                  itemBuilder: (context, index) => Container(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "All $categoryName Recipes",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: Container(
                color: Color.fromARGB(255, 235, 172, 215),
                child: GridView.builder(
                  itemCount: 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.all(6),
                    child: Container(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
