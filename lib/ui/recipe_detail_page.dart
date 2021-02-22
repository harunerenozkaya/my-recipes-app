import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myRecipes/models/recipe.dart';
import '../widgets/recipeDetailWidgets/detail_photo_widget.dart';
import '../widgets/recipeDetailWidgets/detail_ingredients_widget.dart';
import '../widgets/recipeDetailWidgets/detail_step_widget.dart';
import '../widgets/recipeDetailWidgets/detail_customs_widget.dart';

// ignore: must_be_immutable
class RecipeDetail extends StatelessWidget {
  String recipeId;

  RecipeDetail(this.recipeId);

  Recipe recipe;

  getRecipeInfo() {
    Hive.box("recipes").values.toList().forEach(
      (element) {
        if (element.recipeId == recipeId) {
          recipe = element;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;

    getRecipeInfo();

    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 6),
        height: phoneHeight * 0.06,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: RaisedButton(
                  shape: Border.all(color: Colors.purple[300], width: 4),
                  color: Color.fromARGB(255, 235, 172, 215),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/");
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        "Abort",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: RaisedButton(
                  shape: Border.all(color: Colors.purple[300], width: 4),
                  color: Color.fromARGB(255, 235, 172, 215),
                  onPressed: () {},
                  child: Container(
                    child: Center(
                      child: Text("Okay"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 252, 242, 249),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(phoneHeight * 0.06),
        child: AppBar(
          title: Text(
            recipe.recipeName,
            style: TextStyle(
                fontSize: phoneHeight * 0.04, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          primary: true,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: DetailPhotoWidget(recipe.imagesPath, phoneHeight),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 6,
                  child:
                      DetailIngredientsWidget(recipe.ingredients, phoneHeight),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 6,
                  child: DetailStepsWidget(recipe.steps, phoneHeight),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 1,
                  child: DetailCustomsWidget(
                      recipe.recipeDuration, recipe.category, recipe.price),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
