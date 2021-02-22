import 'dart:math';
import 'dart:io';
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
                        side: BorderSide(color: Colors.purple[300], width: 3)),
                    color: Color.fromARGB(255, 235, 172, 215),
                    onPressed: () {
                      deleteImagesWhenAbort();
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: BorderSide(color: Colors.purple[300], width: 3)),
                    color: Color.fromARGB(255, 235, 172, 215),
                    onPressed: () => saveRecipe(context),
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
  void saveRecipe(BuildContext context) async {
    String recipeName;

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
        title: Text("Your recipe has added succesfully"),
        actions: [
          RaisedButton(
            child: Text("Okay"),
            //Ana menüye yönlendirir.
            onPressed: () => Navigator.popAndPushNamed(context, "/"),
          ),
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
        title: Text("What is your recipe name?"),
        content: TextField(
          decoration: InputDecoration(
            labelText: "Recipe Name",
            hintText: "Recipe Name",
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
            onPressed: () async {
              // Name boş mu dolu mu kontrol eder.
              if ((recipeName == null) | (recipeName == "")) {
              } else {
                //Veritabanına ekle
                await recipeBox.add(
                  Recipe(recipeId, imagesPath, ingredients, steps,
                      recipeDuration, category, price, recipeName),
                );
                Navigator.pop(context);
                // Başarılı mesajını döndürür.
                showFinishSuccesfulAlert(context);
              }
            },
            child: Text("Okay"),
          ),
        ],
      ),
    );
  }
}
