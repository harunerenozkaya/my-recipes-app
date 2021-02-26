import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:myRecipes/widgets/editRecipeWidgets/ingredientWidgetEdited.dart';

import '../../app_localization.dart';

// ignore: must_be_immutable
class EditIngredientsWidget extends StatefulWidget {
  final double phoneHeight;
  final Function getIngredients;
  List<Map> ingredients;

  EditIngredientsWidget(
      this.phoneHeight, this.getIngredients, this.ingredients);

  @override
  _EditIngredientsWidgetState createState() => _EditIngredientsWidgetState();
}

class _EditIngredientsWidgetState extends State<EditIngredientsWidget> {
  List<Map> ingredients = [];

  String ingredientUnit = "kg";
  String ingredientName = "";
  String ingredientAmount = "";

  // ignore: must_call_super
  initState() {
    ingredients = widget.ingredients.toList();
    // Tarifin zaten var olan verilerini edit page'deki boş verilere upload eder.
    widget.getIngredients(ingredients);
  }

  void updateStateMainWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    List<String> units = [
      "kg",
      "g",
      "ml",
      "L",
      "lb",
      "pound",
      DemoLocalizations.of(context).translate("spoon"),
      DemoLocalizations.of(context).translate("glass"),
    ];

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DemoLocalizations.of(context)
                        .translate("ingredients_title"),
                    style: TextStyle(fontSize: widget.phoneHeight * 0.03),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.fromLTRB(phoneWidth * 0.015,
                      widget.phoneHeight * 0.01, phoneWidth * 0.25, 0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 208, 222, 229),
                    borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                  ),
                  child: ListView.separated(
                      primary: false,
                      itemBuilder: (context, index) => IngredientWidgetEdited(
                          ingredients[index].values.toList()[0],
                          ingredients[index].values.toList()[2],
                          ingredients[index].values.toList()[1],
                          index,
                          ingredients,
                          updateStateMainWidget,
                          widget.getIngredients),
                      separatorBuilder: (context, index) => Container(
                            height: widget.phoneHeight * 0.008,
                          ),
                      itemCount: ingredients.length),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: phoneWidth * 0.25,
          height: phoneWidth * 0.1,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                side: BorderSide(
                    color: Color.fromARGB(255, 232, 147, 148), width: 3)),
            color: Color.fromARGB(255, 255, 255, 255),
            child: AutoSizeText(
                "${DemoLocalizations.of(context).translate("add_ingredient")}",
                textAlign: TextAlign.center),
            onPressed: () {
              showIngredientAlert(context, keyboardHeight, units);
            },
          ),
        ),
      ],
    );
  }

  // Ingredient ekleme ekranını gösterir
  Future showIngredientAlert(BuildContext context, kh, units) {
    return showDialog(
      context: (context),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            margin: EdgeInsets.only(top: widget.phoneHeight * 0 - kh),
            child: AlertDialog(
              actions: [
                RaisedButton(
                  color: Color.fromARGB(255, 220, 220, 220),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:
                      Text(DemoLocalizations.of(context).translate("cancel")),
                ),
                RaisedButton(
                  onPressed: () => addNewIngredientFunc(),
                  child: Text(DemoLocalizations.of(context).translate("add")),
                  color: Color.fromARGB(255, 232, 147, 148),
                ),
              ],
              title: Text(
                  DemoLocalizations.of(context).translate("alert_add_new_ing")),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) => ingredientName = value,
                      maxLength: 15,
                      cursorHeight: 30,
                      decoration: InputDecoration(
                          labelText: DemoLocalizations.of(context)
                              .translate("ingredient_name"),
                          hintText: DemoLocalizations.of(context)
                              .translate("ingredient_name"),
                          border: OutlineInputBorder(gapPadding: 10)),
                    ),
                    SizedBox(
                      height: widget.phoneHeight * 0.01,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) => ingredientAmount = value,
                            cursorHeight: 30,
                            decoration: InputDecoration(
                                labelText: DemoLocalizations.of(context)
                                    .translate("amount"),
                                hintText: DemoLocalizations.of(context)
                                    .translate("amount"),
                                border: OutlineInputBorder(gapPadding: 10)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 2,
                          child: RaisedButton(
                            color: Color.fromARGB(255, 232, 147, 148),
                            onPressed: () {
                              showMaterialScrollPicker(
                                selectedItem: "L",
                                context: context,
                                cancelText: DemoLocalizations.of(context)
                                    .translate("cancel"),
                                confirmText: DemoLocalizations.of(context)
                                    .translate("choose"),
                                title: DemoLocalizations.of(context)
                                    .translate("choose_unit"),
                                items: units,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      ingredientUnit = value;
                                    },
                                  );
                                },
                              );
                            },
                            child: Text("$ingredientUnit"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Ingredient'i ekler ve ekranı yeniler
  void addNewIngredientFunc() {
    if (ingredientAmount != "" && ingredientName != "") {
      Map addingMap = {
        "ingredientName": ingredientName,
        "ingredientAmount": ingredientAmount,
        "ingredientUnit": ingredientUnit
      };
      ingredients.add(addingMap);
      widget.getIngredients(ingredients);
      Navigator.pop(context);
      updateStateMainWidget();

      ingredientAmount = "";
      ingredientName = "";
    } else {
      // Ingreident Name boş sa uyarı ekranını verir.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            DemoLocalizations.of(context)
                .translate("ingredient_name_cant_blank"),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 232, 147, 148),
          actions: [
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(DemoLocalizations.of(context).translate("okay")),
              color: Colors.white,
            ),
          ],
        ),
      );
    }
  }
}
