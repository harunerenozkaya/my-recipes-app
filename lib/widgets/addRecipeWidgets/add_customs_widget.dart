import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import '../../app_localization.dart';

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
    double phoneHeight = MediaQuery.of(context).size.height;
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
                        size: phoneHeight * 0.027,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                        recipeDuration == null
                            ? "    ${DemoLocalizations.of(context).translate("duration")}"
                            : recipeDuration.inHours < 1
                                ? "     ${recipeDuration.inMinutes}${DemoLocalizations.of(context).translate("minute_tag")}"
                                : recipeDuration.inHours > 0 &&
                                        recipeDuration.inMinutes % 60 == 0
                                    ? "       ${recipeDuration.inHours}${DemoLocalizations.of(context).translate("hour_tag")}"
                                    : "   ${recipeDuration.inHours}${DemoLocalizations.of(context).translate("hour_tag")} ${recipeDuration.inMinutes % 60}${DemoLocalizations.of(context).translate("minute_tag")} ",
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
                      child: Icon(
                        Icons.list,
                        size: phoneHeight * 0.027,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                        category == null
                            ? "   ${DemoLocalizations.of(context).translate("category")}"
                            : " $category",
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
                      child: Icon(
                        Icons.attach_money,
                        size: phoneHeight * 0.027,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                        price == null
                            ? "   ${DemoLocalizations.of(context).translate("price")}"
                            : "   $price",
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
        title: Text(DemoLocalizations.of(context).translate("how_much_cost")),
        content: TextField(
          decoration: InputDecoration(
            labelText: DemoLocalizations.of(context).translate("price"),
            hintText: DemoLocalizations.of(context).translate("price"),
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
            child: Text(DemoLocalizations.of(context).translate("cancel")),
          ),
          RaisedButton(
            onPressed: () {
              setState(
                () {
                  Navigator.pop(context);
                },
              );
            },
            child: Text(DemoLocalizations.of(context).translate("okay")),
            color: Color.fromARGB(255, 235, 172, 215),
          ),
        ],
      ),
    );
  }

  void showCategoryAlert(BuildContext context) {
    return showMaterialRadioPicker(
      items: [
        DemoLocalizations.of(context).translate("practical"),
        DemoLocalizations.of(context).translate("soup"),
        DemoLocalizations.of(context).translate("meatmeal"),
        DemoLocalizations.of(context).translate("vegetable"),
        DemoLocalizations.of(context).translate("legumes"),
        DemoLocalizations.of(context).translate("salad"),
        DemoLocalizations.of(context).translate("pastry"),
        DemoLocalizations.of(context).translate("desert"),
        DemoLocalizations.of(context).translate("snack"),
        DemoLocalizations.of(context).translate("appetizer"),
        DemoLocalizations.of(context).translate("drink"),
      ],
      title: DemoLocalizations.of(context).translate("what_category"),
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
          title: Text(
              DemoLocalizations.of(context).translate("how_much_take_time")),
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
              child: Text(
                DemoLocalizations.of(context).translate("okay"),
              ),
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
