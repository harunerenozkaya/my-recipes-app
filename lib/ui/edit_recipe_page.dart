import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myRecipes/models/recipe.dart';
import 'package:myRecipes/widgets/editRecipeWidgets/edit_customs_widget.dart';
import 'package:myRecipes/widgets/editRecipeWidgets/edit_ingredients_widget.dart';
import 'package:myRecipes/widgets/editRecipeWidgets/edit_photo_widget.dart';
import 'package:myRecipes/widgets/editRecipeWidgets/edit_step_widget.dart';
import 'package:hive/hive.dart';

import '../app_localization.dart';

// ignore: must_be_immutable
class EditRecipePage extends StatelessWidget {
  final String recipeId;

  EditRecipePage(this.recipeId);

  List<String> imagesPath = [];
  List<Map> ingredients = [];
  List steps = [];
  String recipeDuration;
  String category;
  String price;

  Recipe recipe;

  // Gelen recipeId'nin ait olduğu recipe'yi bulur.
  getRecipeInfo() {
    Hive.box("recipes").values.toList().forEach(
      (element) {
        if (element.recipeId == recipeId) {
          recipe = element;
        }
      },
    );
  }

  // Child widgetlerden gelen verileri buraya taşıyoruz ki saveRecipe fonskiyonu ile db'ye ekleyebilelim.
  void getPhotos(List<String> photoss) => imagesPath = photoss;
  void getIngredients(List<Map> ingredientss) => ingredients = ingredientss;
  void getSteps(List stepss) => steps = stepss;
  void getDuration(String recipeDurationx) => recipeDuration = recipeDurationx;
  void getCategory(String categoryx) => category = categoryx;
  void getPrice(String pricex) => price = pricex;

  // Resim seçildiğinde ancak abort'a tıklandığında storage'ye kaydedilmiş olan image'ler silinir.
  void deleteImagesWhenAbort() async {
    imagesPath.forEach(
      (element) {
        File(element).delete();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;

    getRecipeInfo();

    return Scaffold(
      bottomNavigationBar: Container(
        height: phoneHeight * 0.06,
        child: Container(
          margin: EdgeInsets.only(bottom: phoneHeight * 0.01),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    color: Color.fromARGB(255, 232, 147, 148),
                    onPressed: () {
                      deleteImagesWhenAbort();
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          DemoLocalizations.of(context).translate("abort"),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    color: Color.fromARGB(255, 232, 147, 148),
                    onPressed: () => saveRecipe(context),
                    child: Container(
                      child: Center(
                        child: Text(
                            DemoLocalizations.of(context).translate("okay")),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(phoneHeight * 0.06),
        child: AppBar(
          title: Text(
            DemoLocalizations.of(context).translate("edit_recipe_title"),
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
                  child: EditPhotoWidget(
                    phoneHeight,
                    getPhotos,
                    recipe.imagesPath,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 6,
                  child: EditIngredientsWidget(
                    phoneHeight,
                    getIngredients,
                    recipe.ingredients,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 6,
                  child: EditStepsWidget(
                    phoneHeight,
                    getSteps,
                    recipe.steps,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 1,
                  child: EditCustomsWidget(getDuration, getCategory, getPrice,
                      recipe.recipeDuration, recipe.category, recipe.price),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Recipe'yi veritabanına kaydeder.
  void saveRecipe(BuildContext context) async {
    String recipeName = recipe.recipeName;

    if (ingredients.isEmpty) {
      showFinishAlert(
          context, DemoLocalizations.of(context).translate("please_add_ing"));
    } else if (steps.isEmpty) {
      showFinishAlert(
          context, DemoLocalizations.of(context).translate("please_add_step"));
    } else if ((recipeDuration == null) | (recipeDuration == "null")) {
      showFinishAlert(context,
          DemoLocalizations.of(context).translate("please_add_duration"));
    } else if (category == null) {
      showFinishAlert(context,
          DemoLocalizations.of(context).translate("please_add_category"));
    } else if (price == null) {
      showFinishAlert(
          context, DemoLocalizations.of(context).translate("please_add_price"));
    } else {
      var recipeBox = Hive.box("recipes");
      String recipeId = getRandomString();

      showGetRecipeNameAndSaveRecipe(context, recipeName, recipeBox, recipeId);
    }
  }

  // Rastgele bir string döndürür.
  String getRandomString() {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        7,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
  }

  // Eğer herhangi bir değer girilmemişsse uyarı verir .
  showFinishAlert(context, title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
      ),
    );
  }

  // Recipenin başarıyla eklendiğine dair uyarı verir.
  showFinishSuccesfulAlert(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title:
            Text(DemoLocalizations.of(context).translate("edit_succesfully")),
        actions: [
          RaisedButton(
            child: Text(DemoLocalizations.of(context).translate("okay")),
            //Ana menüye yönlendirir.
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false),
          )
        ],
      ),
    );
  }

  showGetRecipeNameAndSaveRecipe(
      BuildContext context, String recipeName, Box recipeBox, String recipeId) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            DemoLocalizations.of(context).translate("do_you_edit_recipe_name")),
        content: TextField(
          controller: TextEditingController(text: recipeName),
          decoration: InputDecoration(
            labelText: DemoLocalizations.of(context).translate("recipe_name"),
            hintText: DemoLocalizations.of(context).translate("recipe_name"),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 3),
            ),
          ),
          onChanged: (val) {
            recipeName = val;
          },
        ),
        actions: [
          RaisedButton(
            onPressed: () {
              // Name boş mu dolu mu kontrol eder.
              if ((recipeName == null) | (recipeName == "")) {
              } else {
                int index = 0;
                //Veritabanındaki recipeyi düzenle
                recipeBox.values.toList().forEach((element) {
                  if (element.recipeId == recipe.recipeId) {
                    recipeBox.putAt(
                        index,
                        Recipe(
                            recipeId,
                            imagesPath,
                            ingredients,
                            steps,
                            recipeDuration,
                            category,
                            price,
                            recipeName,
                            recipe.isFavorite));
                  }
                  index++;
                });

                Navigator.pop(context);
                // Başarılı mesajını döndürür.
                showFinishSuccesfulAlert(context);
              }
            },
            child: Text(DemoLocalizations.of(context).translate("okay")),
          ),
        ],
      ),
    );
  }
}
