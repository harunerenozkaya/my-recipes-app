import 'package:flutter/material.dart';
import 'package:myRecipes/widgets/menu_drawer.dart';
import 'package:myRecipes/widgets/recipe_box.dart';
import 'package:hive/hive.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;
    final phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: MenuDrawer(),
      backgroundColor: Color.fromARGB(255, 252, 242, 249),
      appBar: AppBar(
        title: Text(
          "My Recipes",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              "/addNewRecipe", (Route<dynamic> route) => false);
        },
        tooltip: 'Add New Recipe',
        child: Icon(
          Icons.add,
          size: 40,
          color: Color.fromARGB(255, 235, 172, 215),
        ),
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
                  "My Favorite Recipes",
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
                  "All Recipes",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: Container(
                color: Color.fromARGB(255, 235, 172, 215),
                child: GridView.builder(
                  primary: false,
                  itemCount: Hive.box("recipes").values.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    var recipeId =
                        Hive.box("recipes").values.toList()[index].recipeId;
                    var recipeName =
                        Hive.box("recipes").values.toList()[index].recipeName;
                    //Fotosu olmayanalarda hata veriyo burayı düzelt.
                    bool isRecipeFirstPhoto = Hive.box("recipes")
                        .values
                        .toList()[index]
                        .imagesPath
                        .isEmpty;
                    String recipeFirstPhoto;
                    var recipeDuration = Hive.box("recipes")
                        .values
                        .toList()[index]
                        .recipeDuration;
                    var recipeCategory =
                        Hive.box("recipes").values.toList()[index].category;
                    var recipePrice =
                        Hive.box("recipes").values.toList()[index].price;

                    // Recipe'nin fotografı varsa foto yolla
                    if (isRecipeFirstPhoto == false) {
                      recipeFirstPhoto = Hive.box("recipes")
                          .values
                          .toList()[index]
                          .imagesPath[0];
                    }

                    return RecipeBox(recipeId, recipeName, recipeFirstPhoto,
                        recipeCategory, recipeDuration, recipePrice);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
