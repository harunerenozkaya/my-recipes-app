import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import '../../app_localization.dart';
import 'ingredientWidgetAdded.dart';

class AddIngredientsWidget extends StatefulWidget {
  AddIngredientsWidget({
    Key key,
    @required this.phoneHeight,
    @required this.getIngredients,
  }) : super(key: key);

  final double phoneHeight;
  final Function getIngredients;

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
    List<String> units = [
      "kg",
      "g",
      "lb",
      DemoLocalizations.of(context).translate("spoon"),
      DemoLocalizations.of(context).translate("glass"),
    ];

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
                    DemoLocalizations.of(context)
                        .translate("ingredients_title"),
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
                    color: Color.fromARGB(255, 235, 172, 215),
                    borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                    border: Border.all(color: Colors.purple[300], width: 3),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                side: BorderSide(color: Colors.purple[300], width: 3)),
            color: Color.fromARGB(255, 252, 242, 249),
            child: AutoSizeText(
              "${DemoLocalizations.of(context).translate("add_ingredient")}",
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              showIngredientAlert(context, keyboardHeight, units);
            },
          ),
        ),
      ],
    );
  }

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
                  color: Color.fromARGB(255, 235, 172, 215),
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
                            onPressed: () {
                              showMaterialScrollPicker(
                                selectedItem: "lb",
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
            DemoLocalizations.of(context)
                .translate("ingredient_name_cant_blank"),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 235, 172, 215),
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
