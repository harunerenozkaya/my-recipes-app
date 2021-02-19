import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myRecipes/models/recipe.dart';
import 'package:myRecipes/widgets/addRecipeWidgets/add_customs_widget.dart';
import 'package:myRecipes/widgets/addRecipeWidgets/add_ingredients_widget.dart';
import 'package:myRecipes/widgets/addRecipeWidgets/add_photo_widget.dart';
import 'package:myRecipes/widgets/addRecipeWidgets/add_step_widget.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class AddNewRecipePage extends StatelessWidget {
  List<String> imagesPath = [];
  List<Map> ingredients = [];
  List steps = [];
  String recipeDuration;
  String category;
  String price;

  void getPhotos(List<String> photoss) => imagesPath = photoss;
  void getIngredients(List<Map> ingredientss) => ingredients = ingredientss;
  void getSteps(List stepss) => steps = stepss;
  void getDuration(String recipeDurationx) => recipeDuration = recipeDurationx;
  void getCategory(String categoryx) => category = categoryx;
  void getPrice(String pricex) => price = pricex;

  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: Container(
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
                      child: Text("Abort"),
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
                  onPressed: () => saveReceipt(context),
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
            "Add New Recipe",
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
                  child: AddPhotoWidget(
                      phoneHeight: phoneHeight, getPhotos: getPhotos),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 6,
                  child: AddIngredientsWidget(
                    phoneHeight: phoneHeight,
                    getIngredients: getIngredients,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 6,
                  child: AddStepsWidget(
                    phoneHeight: phoneHeight,
                    getStep: getSteps,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 1,
                  child: AddCustomsWidget(
                    getDuration: getDuration,
                    getCategory: getCategory,
                    getPrice: getPrice,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Recipe'yi veritabanına kaydeder.
  void saveReceipt(BuildContext context) async {
    if (ingredients.isEmpty) {
      showFinishAlert(context, "Please add any ingredient.");
    } else if (steps.isEmpty) {
      showFinishAlert(context, "Please add any step.");
    } else if (recipeDuration == null) {
      showFinishAlert(context, "Please define duration");
    } else if (category == null) {
      showFinishAlert(context, "Please define a category for recipe");
    } else if (price == null) {
      showFinishAlert(context, "Please define a amount");
    } else {
      var recipeBox = Hive.box("recipes");
      String recipeId = getRandomString();

      //Veritabanına ekle
      await recipeBox.add(
        Recipe(recipeId, imagesPath, ingredients, steps, recipeDuration,
            category, price),
      );

      // Test için eklenen recipe'yi yazdırma
      recipeBox.values.forEach(
        (element) {
          debugPrint(
              "$recipeId,$imagesPath,$ingredients,$steps,$recipeDuration,$category,$price");
        },
      );
      showFinishSuccesfulAlert(context);
    }
  }

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

  showFinishAlert(context, title) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
            ));
  }

  showFinishSuccesfulAlert(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Your recipe has added succesfully"),
        actions: [
          RaisedButton(
            child: Text("Okay"),
            onPressed: () => Navigator.popAndPushNamed(context, "/"),
          ),
        ],
      ),
    );
  }
}
