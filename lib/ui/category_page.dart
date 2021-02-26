import 'package:flutter/material.dart';
import 'package:myRecipes/widgets/menu_drawer.dart';
import 'package:myRecipes/widgets/recipe_box.dart';
import 'package:hive/hive.dart';

import '../app_localization.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  final String categoryId;

  CategoryPage(this.categoryName, this.categoryId);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // ignore: missing_return
  Future<bool> _onWillPop() {
    Navigator.popAndPushNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;
    final phoneWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: MenuDrawer(),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Text(
            DemoLocalizations.of(context).translate("home_title"),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                "/addNewRecipe", (Route<dynamic> route) => false);
          },
          child: Icon(
            Icons.add,
            size: 40,
            color: Color.fromARGB(255, 232, 147, 148),
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
                  padding: EdgeInsets.only(bottom: phoneHeight * 0.004),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "${DemoLocalizations.of(context).translate("before_category_title_fav")} ${widget.categoryName} ${DemoLocalizations.of(context).translate("after_category_title_fav")}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                    color: Color.fromARGB(255, 208, 222, 229),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: phoneHeight * 0.005,
                      horizontal: phoneWidth * 0.001),
                  child: findFavoriteCategoryRecipeCount() != 0
                      ? ListView.builder(
                          itemExtent: phoneWidth * 0.46,
                          scrollDirection: Axis.horizontal,
                          itemCount: findFavoriteCategoryRecipeCount(),
                          itemBuilder: (context, index) {
                            return getFavoriteCategoryRecipeList()[index];
                          },
                        )
                      : Container(
                          child: Center(
                            child: Text(
                                "${DemoLocalizations.of(context).translate("fav_before_category_recipe")} ${widget.categoryName} ${DemoLocalizations.of(context).translate("fav_after_category_recipe")}."),
                          ),
                        ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(bottom: phoneHeight * 0.004),
                  child: Text(
                    "${DemoLocalizations.of(context).translate("before_category_title")} ${widget.categoryName} ${DemoLocalizations.of(context).translate("after_category_title")}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                    color: Color.fromARGB(255, 208, 222, 229),
                  ),
                  child: findAllCategoryRecipeCount() != 0
                      ? GridView.builder(
                          primary: false,
                          itemCount: findAllCategoryRecipeCount(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return getCategoryRecipeList()[index];
                          },
                        )
                      : Container(
                          child: Center(
                            child: Text(
                              "${DemoLocalizations.of(context).translate("before_category_recipe")} ${widget.categoryName} ${DemoLocalizations.of(context).translate("after_category_recipe")} ",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int findFavoriteCategoryRecipeCount() {
    int count = 0;
    Hive.box("recipes").values.toList().forEach((element) {
      if (element.category == widget.categoryName) {
        if (element.isFavorite == true) {
          count++;
        }
      }
    });

    return count;
  }

  int findAllCategoryRecipeCount() {
    int count = 0;
    Hive.box("recipes").values.toList().forEach((element) {
      if (element.category == widget.categoryName) {
        count++;
      }
    });

    return count;
  }

  List<Widget> getCategoryRecipeList() {
    List<Widget> recipes = [];
    Hive.box("recipes").values.toList().forEach(
      (element) {
        if (element.category == widget.categoryName) {
          var recipeId = element.recipeId;
          var recipeName = element.recipeName;
          //Fotosu olmayanlarda hata veriyo burayı düzelt.
          bool isRecipeFirstPhoto = element.imagesPath.isEmpty;
          String recipeFirstPhoto;
          var recipeDuration = element.recipeDuration;
          var recipeCategory = element.category;
          var recipePrice = element.price;

          // Recipe'nin fotografı varsa foto yolla
          if (isRecipeFirstPhoto == false) {
            recipeFirstPhoto = element.imagesPath[0];
          }

          recipes.add(RecipeBox(recipeId, recipeName, recipeFirstPhoto,
              recipeCategory, recipeDuration, recipePrice));
        }
      },
    );
    return recipes;
  }

  List<Widget> getFavoriteCategoryRecipeList() {
    List<Widget> recipes = [];
    Hive.box("recipes").values.toList().forEach(
      (element) {
        if (element.category == widget.categoryName) {
          if (element.isFavorite == true) {
            var recipeId = element.recipeId;
            var recipeName = element.recipeName;
            //Fotosu olmayanlarda hata veriyo burayı düzelt.
            bool isRecipeFirstPhoto = element.imagesPath.isEmpty;
            String recipeFirstPhoto;
            var recipeDuration = element.recipeDuration;
            var recipeCategory = element.category;
            var recipePrice = element.price;

            // Recipe'nin fotografı varsa foto yolla
            if (isRecipeFirstPhoto == false) {
              recipeFirstPhoto = element.imagesPath[0];
            }

            recipes.add(RecipeBox(recipeId, recipeName, recipeFirstPhoto,
                recipeCategory, recipeDuration, recipePrice));
          }
        }
      },
    );
    return recipes;
  }
}
