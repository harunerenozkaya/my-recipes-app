import 'package:flutter/material.dart';
import 'package:myRecipes/widgets/menu_drawer.dart';
import 'package:myRecipes/widgets/recipe_box.dart';
import 'package:hive/hive.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  final String categoryId;

  CategoryPage(this.categoryName, this.categoryId);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
        tooltip: 'Add New ${widget.categoryName} Recipe',
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
                padding: EdgeInsets.only(bottom: phoneHeight * 0.004),
                alignment: Alignment.bottomLeft,
                child: Text(
                  "My Favorite ${widget.categoryName} Recipes",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                  color: Color.fromARGB(255, 235, 172, 215),
                  border: Border.all(
                    width: 3,
                    color: Colors.purple[300],
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: phoneHeight * 0.005,
                    horizontal: phoneWidth * 0.001),
                child: findFavoriteCategoryRecipeCount() != 0
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: findFavoriteCategoryRecipeCount(),
                        separatorBuilder: (context, index) => SizedBox(
                          width: phoneWidth * 0.02,
                        ),
                        itemBuilder: (context, index) {
                          return getFavoriteCategoryRecipeList()[index];
                        },
                      )
                    : Container(
                        child: Center(
                          child: Text(
                              "There is not any favorite  ${widget.categoryName} recipe."),
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
                  "All ${widget.categoryName} Recipes",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                  color: Color.fromARGB(255, 235, 172, 215),
                  border: Border.all(
                    width: 3,
                    color: Colors.purple[300],
                  ),
                ),
                child: findAllCategoryRecipeCount() != 0
                    ? GridView.builder(
                        primary: false,
                        itemCount: findAllCategoryRecipeCount(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return getCategoryRecipeList()[index];
                        },
                      )
                    : Container(
                        child: Center(
                          child: Text(
                            "There is not any  ${widget.categoryName} recipe.\nYou can add new recipes with the button in the \nbottom right corner.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
              ),
            ),
          ],
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
