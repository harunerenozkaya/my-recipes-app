import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:myRecipes/widgets/menu_drawer.dart';
import 'package:myRecipes/widgets/recipe_box.dart';
import 'package:hive/hive.dart';

import '../app_localization.dart';

class MyHomePage extends StatelessWidget {
  // Reklamların çalışması için admob'u initialize ediyoruz.
  Future<void> _initAdMob() {
    return FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-2763602296626502~8247078922");
  }

  // Ana sayfada geri tuşuna basılınca hiç bir şey yapma
  // ignore: missing_return
  Future<bool> _onWillPop() {}

  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;
    final phoneWidth = MediaQuery.of(context).size.width;

    _initAdMob();

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
            //Floating Action Button'a basılınca yeni tarif ekleme ekranına yönlendir
            Navigator.of(context).pushNamed("/addNewRecipe");
          },
          tooltip: 'Add New Recipe',
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
                    DemoLocalizations.of(context)
                        .translate("favorite_recipes_title"),
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
                  child: findFavoriteRecipeCount() != 0
                      ? ListView.builder(
                          itemExtent: phoneWidth * 0.46,
                          scrollDirection: Axis.horizontal,
                          itemCount: findFavoriteRecipeCount(),
                          itemBuilder: (context, index) {
                            return getAllFavoriteRecipesList()[index];
                          },
                        )
                      : Container(
                          child: Center(
                            child: Text(
                              DemoLocalizations.of(context)
                                  .translate("there_is_not_fv_rcp"),
                            ),
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
                    DemoLocalizations.of(context)
                        .translate("all_recipes_title"),
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
                  child: findAllRecipeCount() != 0
                      ? GridView.builder(
                          primary: false,
                          itemCount: Hive.box("recipes").values.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            var recipes = Hive.box("recipes").values.toList();
                            var recipeId = recipes[index].recipeId;
                            var recipeName = recipes[index].recipeName;
                            //Fotosu olmayanalarda hata veriyo burayı düzelt.
                            bool isRecipeFirstPhoto =
                                recipes[index].imagesPath.isEmpty;
                            String recipeFirstPhoto;
                            var recipeDuration = recipes[index].recipeDuration;
                            var recipeCategory = recipes[index].category;
                            var recipePrice = recipes[index].price;

                            // Recipe'nin fotografı varsa foto yolla
                            if (isRecipeFirstPhoto == false) {
                              recipeFirstPhoto = Hive.box("recipes")
                                  .values
                                  .toList()[index]
                                  .imagesPath[0];
                            }

                            return RecipeBox(
                                recipeId,
                                recipeName,
                                recipeFirstPhoto,
                                recipeCategory,
                                recipeDuration,
                                recipePrice);
                          },
                        )
                      : Container(
                          child: Center(
                            child: Text(
                              DemoLocalizations.of(context)
                                  .translate("there_is_not_rcp"),
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

  // Favorilere eklenmiş tarif sayısını bulur.
  int findFavoriteRecipeCount() {
    int count = 0;
    Hive.box("recipes").values.toList().forEach((element) {
      if (element.isFavorite == true) {
        count++;
      }
    });

    return count;
  }

  // Eklenmiş tüm tariflerin sayısını bulur
  int findAllRecipeCount() {
    int count = 0;
    Hive.box("recipes").values.toList().forEach((element) {
      count++;
    });

    return count;
  }

  // Tüm favori recipe'ları bir listeye koyar
  List<Widget> getAllFavoriteRecipesList() {
    List<Widget> recipes = [];
    Hive.box("recipes").values.toList().forEach(
      (element) {
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
      },
    );
    return recipes;
  }
}
