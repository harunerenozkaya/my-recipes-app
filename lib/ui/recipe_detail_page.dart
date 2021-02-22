import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myRecipes/models/recipe.dart';
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

class _RecipeDetailState extends State<RecipeDetail> {
  Recipe recipe;

  getRecipeInfo() {
    Hive.box("recipes").values.toList().forEach(
      (element) {
        if (element.recipeId == widget.recipeId) {
          recipe = element;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;
    final phoneWidth = MediaQuery.of(context).size.width;

    getRecipeInfo();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 242, 249),
      bottomNavigationBar: Container(
        height: phoneHeight * 0.065,
        margin: EdgeInsets.fromLTRB(
            phoneWidth * 0.1, 0, phoneWidth * 0.1, phoneHeight * 0.01),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 235, 172, 215),
              borderRadius: BorderRadius.all(Radius.elliptical(15, 15))),
          child: Row(
            children: [
              Expanded(
                child: RaisedButton(
                  onPressed: () => showDeleteAlert(context),
                  shape: CircleBorder(),
                  color: Colors.white,
                  child: Icon(
                    Icons.delete,
                    color: Colors.purple[300],
                    size: 25,
                  ),
                ),
              ),
              Expanded(
                child: RaisedButton(
                  onPressed: () {},
                  shape: CircleBorder(),
                  color: Colors.white,
                  child: Icon(
                    Icons.edit,
                    color: Colors.purple[300],
                    size: 25,
                  ),
                ),
              ),
              Expanded(
                child: RaisedButton(
                  onPressed: () => changeIsFavoriteStatus(),
                  shape: CircleBorder(),
                  color: Colors.white,
                  child: recipe.isFavorite == false
                      ? Icon(
                          Icons.star_border_outlined,
                          color: Colors.purple[300],
                          size: 25,
                        )
                      : Icon(
                          Icons.star,
                          color: Colors.purple[300],
                          size: 25,
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
            color: Color.fromARGB(255, 235, 172, 215),
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

  showDeleteAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("This recipe will delete !\nAre you sure ?"),
        actions: [
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Abort"),
          ),
          RaisedButton(
            onPressed: () => deleteRecipe(context),
            child: Text(
              "Delete",
            ),
            color: Color.fromARGB(255, 235, 172, 215),
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
          Navigator.popAndPushNamed(context, "/");
          index++;
        }
      },
    );
  }

  changeIsFavoriteStatus() {
    Hive.box("recipes").values.toList().forEach(
      (element) {
        setState(
          () {
            if (element.recipeId == widget.recipeId) {
              if (recipe.isFavorite == false) {
                element.isFavorite = true;
              } else if (recipe.isFavorite == true) {
                element.isFavorite = false;
              }
            }
          },
        );
      },
    );
  }
}
