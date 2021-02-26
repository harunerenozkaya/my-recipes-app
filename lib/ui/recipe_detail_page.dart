import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myRecipes/models/recipe.dart';
import '../app_localization.dart';
import '../widgets/recipeDetailWidgets/detail_photo_widget.dart';
import '../widgets/recipeDetailWidgets/detail_ingredients_widget.dart';
import '../widgets/recipeDetailWidgets/detail_step_widget.dart';
import '../widgets/recipeDetailWidgets/detail_customs_widget.dart';

// ignore: must_be_immutable
class RecipeDetail extends StatefulWidget {
  String recipeId;

  RecipeDetail(this.recipeId);

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

Recipe recipe;

class _RecipeDetailState extends State<RecipeDetail> {
  List getDataofRecipe(String recipeId) {
    List recipeData;

    var index = 0;
    Hive.box("recipes").values.forEach(
      (element) {
        if (element.recipeId == recipeId) {
          recipeData = [
            Hive.box("recipes").getAt(index).recipeId,
            Hive.box("recipes").getAt(index).imagesPath,
            Hive.box("recipes").getAt(index).ingredients,
            Hive.box("recipes").getAt(index).steps,
            Hive.box("recipes").getAt(index).recipeDuration,
            Hive.box("recipes").getAt(index).category,
            Hive.box("recipes").getAt(index).price,
            Hive.box("recipes").getAt(index).recipeName,
            Hive.box("recipes").getAt(index).isFavorite
          ];
        }
        index++;
      },
    );
    return recipeData;
  }

  // ignore: missing_return
  Future<bool> _onWillPop() {
    Navigator.popAndPushNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;
    final phoneWidth = MediaQuery.of(context).size.width;
    List recipeData = getDataofRecipe(widget.recipeId);

    recipe = Recipe(
      recipeData[0],
      recipeData[1],
      recipeData[2],
      recipeData[3],
      recipeData[4],
      recipeData[5],
      recipeData[6],
      recipeData[7],
      recipeData[8],
    );

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        bottomNavigationBar: Container(
          height: phoneHeight * 0.056,
          margin: EdgeInsets.fromLTRB(
              phoneWidth * 0.1, 0, phoneWidth * 0.1, phoneHeight * 0.01),
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 232, 147, 148),
                borderRadius: BorderRadius.all(Radius.elliptical(15, 15))),
            child: Row(
              children: [
                Expanded(
                  child: ButtonTheme(
                    height: phoneHeight * 0.045,
                    child: RaisedButton(
                      onPressed: () => showDeleteAlert(context),
                      shape: CircleBorder(),
                      color: Colors.white,
                      child: Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 232, 147, 148),
                        size: phoneHeight * 0.03,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ButtonTheme(
                    height: phoneHeight * 0.045,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, "editPage/${recipe.recipeId}");
                      },
                      shape: CircleBorder(),
                      color: Colors.white,
                      child: Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 232, 147, 148),
                        size: phoneHeight * 0.03,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ButtonTheme(
                    height: phoneHeight * 0.045,
                    child: RaisedButton(
                      onPressed: () => changeIsFavoriteStatus(),
                      shape: CircleBorder(),
                      color: Colors.white,
                      child: recipe.isFavorite == false
                          ? Icon(
                              Icons.star_border_outlined,
                              color: Color.fromARGB(255, 232, 147, 148),
                              size: phoneHeight * 0.03,
                            )
                          : Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 232, 147, 148),
                              size: phoneHeight * 0.03,
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(phoneHeight * 0.06),
          child: AppBar(
            centerTitle: true,
            title: Text(
              recipe.recipeName,
              style: TextStyle(
                  fontSize: phoneHeight * 0.04, fontWeight: FontWeight.bold),
            ),
            leading: RaisedButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, "/");
              },
              color: Color.fromARGB(255, 232, 147, 148),
              elevation: 0,
              child: Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 100,
                child: DetailPhotoWidget(recipe.imagesPath, phoneHeight),
              ),
              Expanded(
                flex: 20,
                child: SizedBox(),
              ),
              Expanded(
                flex: 120,
                child: DetailIngredientsWidget(recipe.ingredients, phoneHeight),
              ),
              Expanded(
                flex: 20,
                child: SizedBox(),
              ),
              Expanded(
                flex: 120,
                child: DetailStepsWidget(recipe.steps, phoneHeight),
              ),
              Expanded(
                flex: 20,
                child: SizedBox(),
              ),
              Expanded(
                flex: 20,
                child: DetailCustomsWidget(
                    recipe.recipeDuration, recipe.category, recipe.price),
              ),
              Expanded(
                flex: 10,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDeleteAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            DemoLocalizations.of(context).translate("alert_recipe_delete")),
        actions: [
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(DemoLocalizations.of(context).translate("abort")),
            color: Color.fromARGB(255, 200, 200, 200),
          ),
          RaisedButton(
            onPressed: () => deleteRecipe(context),
            child: Text(
              DemoLocalizations.of(context).translate("delete"),
            ),
            color: Color.fromARGB(255, 232, 147, 148),
          )
        ],
      ),
    );
  }

  deleteRecipe(BuildContext context) {
    int index = 0;
    Hive.box("recipes").values.toList().forEach(
      (element) {
        if (element.recipeId == widget.recipeId) {
          Hive.box("recipes").deleteAt(index);
          print("deleteded $index");
          Navigator.popAndPushNamed(context, "/");
        }
        index++;
      },
    );
  }

  changeIsFavoriteStatus() {
    var index = 0;
    Hive.box("recipes").values.toList().forEach(
      (element) {
        setState(
          () {
            if (element.recipeId == widget.recipeId) {
              if (recipe.isFavorite == false) {
                Hive.box("recipes").putAt(
                    index,
                    Recipe(
                        recipe.recipeId,
                        recipe.imagesPath,
                        recipe.ingredients,
                        recipe.steps,
                        recipe.recipeDuration,
                        recipe.category,
                        recipe.price,
                        recipe.recipeName,
                        true));
              } else if (recipe.isFavorite == true) {
                Hive.box("recipes").putAt(
                    index,
                    Recipe(
                        recipe.recipeId,
                        recipe.imagesPath,
                        recipe.ingredients,
                        recipe.steps,
                        recipe.recipeDuration,
                        recipe.category,
                        recipe.price,
                        recipe.recipeName,
                        false));
              }
            }
          },
        );
        index++;
      },
    );
  }
}
