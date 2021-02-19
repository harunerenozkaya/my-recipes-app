import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:myRecipes/widgets/addRecipeWidgets/ingredientWidget.dart';

class AddIngredientsWidget extends StatefulWidget {
  AddIngredientsWidget({
    Key key,
    @required this.phoneHeight,
    @required this.getIngredients,
  }) : super(key: key);

  final double phoneHeight;
  final Function getIngredients;

  static const List<String> units = ["kg", "g", "lb", "spoon", "glass"];

  @override
  _AddIngredientsWidgetState createState() => _AddIngredientsWidgetState();
}

class _AddIngredientsWidgetState extends State<AddIngredientsWidget> {
  List<Map> ingredients = [];

  String ingredientUnit = "kg";
  String ingredientName = "";
  String ingredientAmount = "";

  void updateStateMainWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

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
                    "Ingredients",
                    style: TextStyle(fontSize: widget.phoneHeight * 0.03),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.fromLTRB(phoneWidth * 0.01,
                      widget.phoneHeight * 0.005, phoneWidth * 0.25, 0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3),
                    color: Color.fromARGB(255, 235, 172, 215),
                  ),
                  child: ListView.separated(
                      primary: false,
                      itemBuilder: (context, index) => IngredientWidget(
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
            shape: Border.all(width: 3),
            color: Color.fromARGB(255, 252, 242, 249),
            child: AutoSizeText(
              "     Add Ingredient",
            ),
            onPressed: () {
              showIngredientAlert(context, keyboardHeight);
            },
          ),
        ),
      ],
    );
  }

  Future showIngredientAlert(BuildContext context, kh) {
    return showDialog(
      context: (context),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            margin: EdgeInsets.only(top: widget.phoneHeight * 0 - kh),
            child: AlertDialog(
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                RaisedButton(
                  onPressed: () => addNewIngredientFunc(),
                  child: Text("Add"),
                  color: Color.fromARGB(255, 235, 172, 215),
                ),
              ],
              title: Text("Add New Ingredients"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) => ingredientName = value,
                      maxLength: 15,
                      cursorHeight: 30,
                      decoration: InputDecoration(
                          labelText: "Ingredient Name",
                          hintText: "Ingredint Name",
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
                                labelText: "Amount",
                                hintText: "Amount",
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
                            onPressed: () {
                              showMaterialScrollPicker(
                                selectedItem: "lb",
                                context: context,
                                cancelText: "Cancel",
                                confirmText: "Choose",
                                title: "Choose unit",
                                items: AddIngredientsWidget.units,
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
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            "Ingredient name or amount can't be blank.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
          actions: [
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Okay"),
              color: Colors.white,
            ),
          ],
        ),
      );
    }
  }
}
