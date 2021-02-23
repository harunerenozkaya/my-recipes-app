import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class AddCustomsWidget extends StatefulWidget {
  AddCustomsWidget({
    Key key,
    @required this.getDuration,
    @required this.getCategory,
    @required this.getPrice,
  }) : super(key: key);

  final Function getDuration;
  final Function getCategory;
  final Function getPrice;

  @override
  _AddCustomsWidgetState createState() => _AddCustomsWidgetState();
}

class _AddCustomsWidgetState extends State<AddCustomsWidget> {
  Duration recipeDuration;
  String category;
  String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {
                showDurationAlert(context);
              },
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                  color: Color.fromARGB(255, 252, 242, 249),
                  border: Border.all(
                    width: 3,
                    color: Colors.purple[300],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.timer,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                        recipeDuration == null
                            ? "  Duration"
                            : recipeDuration.inHours < 1
                                ? "     ${recipeDuration.inMinutes}m"
                                : recipeDuration.inHours > 0 &&
                                        recipeDuration.inMinutes % 60 == 0
                                    ? "       ${recipeDuration.inHours}h"
                                    : "   ${recipeDuration.inHours}h ${recipeDuration.inMinutes % 60}m ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {
                showCategoryAlert(context);
              },
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                  color: Color.fromARGB(255, 252, 242, 249),
                  border: Border.all(
                    width: 3,
                    color: Colors.purple[300],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.list),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                        category == null ? "  Category" : " $category",
                        style: TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {
                showPriceDialog(context);
              },
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                  color: Color.fromARGB(255, 252, 242, 249),
                  border: Border.all(
                    width: 3,
                    color: Colors.purple[300],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.attach_money),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                        price == null ? "  Amount" : "   $price",
                        style: TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future showPriceDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("How much does it cost?"),
        content: TextField(
          decoration: InputDecoration(
            labelText: "Price",
            hintText: "Price",
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 3),
            ),
          ),
          keyboardType: TextInputType.number,
          onChanged: (val) {
            price = val;
            widget.getPrice(price);
          },
        ),
        actions: [
          RaisedButton(
            color: Color.fromARGB(255, 220, 220, 220),
            onPressed: () {
              setState(
                () {
                  price = null;
                  Navigator.pop(context);
                },
              );
            },
            child: Text("Cancel"),
          ),
          RaisedButton(
            onPressed: () {
              setState(
                () {
                  Navigator.pop(context);
                },
              );
            },
            child: Text("Okay"),
            color: Color.fromARGB(255, 235, 172, 215),
          ),
        ],
      ),
    );
  }

  void showCategoryAlert(BuildContext context) {
    return showMaterialRadioPicker(
      items: [
        "Practical",
        "Soup",
        "Meat Meal",
        "Vegetable",
        "Legumes",
        "Salad",
        "Pastry",
        "Desert",
        "Snack",
        "Appetizer",
        "Drink"
      ],
      title: "What is the category?",
      headerColor: Color.fromARGB(255, 235, 172, 215),
      context: context,
      onChanged: (val) {
        setState(
          () {
            category = val;
            widget.getCategory(category);
          },
        );
      },
    );
  }

  Future showDurationAlert(BuildContext context) {
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("How much does it take to ready?"),
          content: DurationPicker(
            snapToMins: 5,
            onChange: (val) {
              setState(
                () {
                  recipeDuration = val;
                  widget.getDuration(recipeDuration.toString());
                },
              );
            },
          ),
          actions: [
            RaisedButton(
              color: Color.fromARGB(255, 235, 172, 215),
              child: Text("Okay"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
