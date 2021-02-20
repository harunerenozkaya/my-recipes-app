import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RecipeBox extends StatelessWidget {
  final String recipeName;
  final String recipeImageBase64;
  final String category;
  final String time;
  final String money;

  RecipeBox(this.recipeName, this.recipeImageBase64, this.category, this.time,
      this.money);

  String parseTime(String time) {
    if (time.split(":")[0] == "0") {
      return "${time.split(":")[1]}m";
    } else {
      return "${time.split(":")[0]}h ${time.split(":")[1]}m";
    }
  }

  @override
  Widget build(BuildContext context) {
    final phoneWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(7),
      child: GestureDetector(
        onTap: () {
          Hive.box("recipes").values.toList().forEach(
            (element) {
              print(element.recipeId);
            },
          );
        },
        child: Container(
          width: phoneWidth * 0.35,
          color: Colors.white,
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.purple[300],
                  child: Center(
                    child: Text(
                      "$recipeName",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  padding: EdgeInsets.all(2),
                  child: recipeImageBase64 != null
                      ? Image.memory(
                          base64Decode(recipeImageBase64),
                          fit: BoxFit.fill,
                        )
                      : Image.asset("assets/images/cupcake.jpg"),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          color: Colors.purple[300],
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "$category",
                                style: TextStyle(color: Colors.white),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          color: Colors.purple[300],
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                parseTime(time),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          color: Colors.purple[300],
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "$money\$ ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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
