import 'package:flutter/material.dart';

import '../app_localization.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double phoneWidth = MediaQuery.of(context).size.width;
    final double phoneHeight = MediaQuery.of(context).size.height;

    Map menuItemNamesId = {
      DemoLocalizations.of(context).translate("home"): "home",
      DemoLocalizations.of(context).translate("practical"): "practical",
      DemoLocalizations.of(context).translate("soup"): "soup",
      DemoLocalizations.of(context).translate("meatmeal"): "meat_meal",
      DemoLocalizations.of(context).translate("vegetable"): "vegetable_meal",
      DemoLocalizations.of(context).translate("legumes"): "legumes",
      DemoLocalizations.of(context).translate("salad"): "salad",
      DemoLocalizations.of(context).translate("pastry"): "pastry",
      DemoLocalizations.of(context).translate("desert"): "desert",
      DemoLocalizations.of(context).translate("snack"): "snack",
      DemoLocalizations.of(context).translate("appetizer"): "appetizer",
      DemoLocalizations.of(context).translate("drink"): "drink"
    };

    return Container(
      width: phoneWidth * 0.4,
      child: Drawer(
        child: Container(
          padding: EdgeInsets.only(top: phoneHeight * 0.03),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    DemoLocalizations.of(context).translate("categories_title"),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Divider(
                    indent: phoneWidth * 0.05,
                    endIndent: phoneWidth * 0.05,
                    thickness: 3,
                    color: Color.fromARGB(255, 235, 172, 215),
                  )),
              Expanded(
                flex: 60,
                child: Transform.translate(
                  // Kategorileri başlıga yakınlaştırdım
                  offset: Offset(0, -phoneHeight * 0.02),
                  child: Container(
                    child: ListView.builder(
                      itemExtent: phoneHeight * 0.072,
                      primary: false,
                      itemCount: menuItemNamesId.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Transform.translate(
                            // Title'yi leading'e yaklaştırdı
                            offset: Offset(-phoneWidth * 0.03, 0),
                            child: Text(
                              "${menuItemNamesId.keys.toList()[index]}",
                              style: TextStyle(fontSize: phoneWidth / 26),
                            )),
                        leading: Icon(
                          Icons.star_outline_sharp,
                          color: Color.fromARGB(255, 235, 172, 215),
                          size: 30,
                        ),
                        visualDensity: VisualDensity(horizontal: -4),
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "categoryPage/${menuItemNamesId.keys.toList()[index]}/${menuItemNamesId.values.toList()[index]}",
                              (Route<dynamic> route) => false);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
