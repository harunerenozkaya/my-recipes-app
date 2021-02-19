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

    final List<RecipeBox> recipeBoxes = [
      RecipeBox(
          "Köfte",
          "https://imgrosetta.mynet.com.tr/file/9951142/9951142-728xauto.jpg",
          "Hard",
          "20",
          "1"),
      RecipeBox(
          "Çorba",
          "https://im.haberturk.com/2020/04/23/ver1587621896/2655814_414x414.jpg",
          "Easy",
          "30",
          "2"),
      RecipeBox(
          "Mantı",
          "https://im.haberturk.com/2020/11/28/ver1606574471/2885324_810x458.jpg",
          "Medium",
          "10",
          "3"),
      RecipeBox(
          "Salata",
          "https://i4.hurimg.com/i/hurriyet/75/750x422/5e5920c4c9de3d09c015ab50.jpg",
          "Hard",
          "15",
          "4"),
      RecipeBox(
          "Pasta",
          "https://www.lifeloveandsugar.com/wp-content/uploads/2018/04/Raspberry-Chocolate-Layer-Cake3.jpg",
          "Easy",
          "25",
          "5")
    ];

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
                  itemCount: recipeBoxes.length,
                  separatorBuilder: (context, index) => SizedBox(
                    width: phoneWidth * 0.02,
                  ),
                  itemBuilder: (context, index) => recipeBoxes[index],
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
                  itemCount: recipeBoxes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.all(6),
                    child: recipeBoxes[index],
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
