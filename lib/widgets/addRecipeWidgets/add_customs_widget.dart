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
    double phoneWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {
                showDurationAlert(context, phoneHeight);
              },
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(
                    width: 3,
                    color: Color.fromARGB(255, 232, 147, 148),
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
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: phoneWidth > 600.0
                                ? phoneWidth * 0.03
                                : phoneWidth * 0),
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
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(
                    width: 3,
                    color: Color.fromARGB(255, 232, 147, 148),
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
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: phoneWidth > 600.0
                                ? phoneWidth * 0.03
                                : phoneWidth * 0),
                        child: AutoSizeText(
                          category == null
                              ? "   ${DemoLocalizations.of(context).translate("category")}"
                              : " $category",
                          style: TextStyle(fontWeight: FontWeight.w600),
                          maxLines: 1,
                        ),
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
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(
                    width: 3,
                    color: Color.fromARGB(255, 232, 147, 148),
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
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: phoneWidth > 600.0
                                ? phoneWidth * 0.03
                                : phoneWidth * 0.03),
                        child: AutoSizeText(
                          price == null
                              ? "${DemoLocalizations.of(context).translate("price")}"
                              : "$price",
                          style: TextStyle(fontWeight: FontWeight.w600),
                          maxLines: 1,
                        ),
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

  // Price seçme ekranını gösterir.
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
            color: Color.fromARGB(255, 232, 147, 148),
          ),
        ],
      ),
    );
  }

  // Kategori seçme ekranını gösterir.
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
      headerColor: Color.fromARGB(255, 232, 147, 148),
      headerTextColor: Colors.black,
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

  // Zaman seçme ekranını gösterir.
  Future showDurationAlert(BuildContext context, double phoneHeight) async {
    Duration resultingDuration = await showDurationPicker(
      context: context,
      initialTime: new Duration(minutes: 0),
      header: Container(
        alignment: Alignment.centerLeft,
        color: Color.fromARGB(255, 232, 147, 148),
        child: Center(
          child: Text(
            DemoLocalizations.of(context).translate("how_much_take_time"),
            style: TextStyle(fontSize: phoneHeight * 0.020),
          ),
        ),
      ),
      snapToMins: 5,
      heightx: 1.3,
      heightHeader: 15,
      buttonColorOk: Color.fromARGB(255, 232, 147, 148),
      buttonColorCancel: Color.fromARGB(255, 220, 220, 220),
    );

    setState(
      () {
        recipeDuration = resultingDuration;
        widget.getDuration(recipeDuration.toString());
      },
    );
  }
}
