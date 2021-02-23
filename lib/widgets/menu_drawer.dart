import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  static const Map menuItemNamesId = {
    "Home": "home",
    "Practical": "practical",
    "Soup": "soup",
    "Meat Meal": "meat_meal",
    "Vegetable": "vegetable_meal",
    "Legumes": "legumes",
    "Salad": "salad",
    "Pastry": "pastry",
    "Desert": "desert",
    "Snack": "snack",
    "Appetizer": "appetizer",
    "Drink": "drink"
  };

  @override
  Widget build(BuildContext context) {
    final double phoneWidth = MediaQuery.of(context).size.width;
    final double phoneHeight = MediaQuery.of(context).size.height;

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
                    "Categories",
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
