import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class AddIngredientsWidget extends StatefulWidget {
  AddIngredientsWidget({
    Key key,
    @required this.phoneHeight,
  }) : super(key: key);

  final double phoneHeight;

  static const List<String> units = ["kg", "g", "lb", "spoon", "glass"];

  @override
  _AddIngredientsWidgetState createState() => _AddIngredientsWidgetState();
}

class _AddIngredientsWidgetState extends State<AddIngredientsWidget> {
  List<Map> ingredients = [];

  String ingredientUnit = "kg";
  String ingredientName;
  String ingredientAmount;

  void updateStateMainWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  decoration: BoxDecoration(
                    border: Border.all(width: 3),
                    color: Color.fromARGB(255, 235, 172, 215),
                  ),
                  child: ListView.separated(
                      itemBuilder: (context, index) => Text(
                          "${ingredients[index].values.toList()[0]} ${ingredients[index].values.toList()[1]} ${ingredients[index].values.toList()[2]}"),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: ingredients.length),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: widget.phoneHeight * 0.189),
          alignment: Alignment.topRight,
          child: RaisedButton(
            shape: Border.all(width: 3),
            color: Color.fromARGB(255, 252, 242, 249),
            child: Text("Add Ingredient"),
            onPressed: () {
              showIngredientAlert(context);
            },
          ),
        ),
      ],
    );
  }

  Future showIngredientAlert(BuildContext context) {
    return showDialog(
      context: (context),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
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
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) => ingredientName = value,
                  maxLength: 30,
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
          );
        },
      ),
    );
  }

  void addNewIngredientFunc() {
    Map addingMap = {
      "ingredientName": ingredientName,
      "ingredientAmount": ingredientAmount,
      "ingredientUnit": ingredientUnit
    };

    ingredients.add(addingMap);

    Navigator.pop(context);
    updateStateMainWidget();
  }
}
