import 'package:flutter/material.dart';
import 'dart:io';

import 'package:loading_gifs/loading_gifs.dart';

class RecipeBox extends StatelessWidget {
  final String recipeId;
  final String recipeName;
  final String recipeImagePath;
  final String category;
  final String time;
  final String money;

  RecipeBox(this.recipeId, this.recipeName, this.recipeImagePath, this.category,
      this.time, this.money);

  String parseTime(String time) {
    List timePeriods = time.split(":");

    if (timePeriods[0] == "0") {
      return "${timePeriods[1]}m";
    } else if (timePeriods[0] != "0" && timePeriods[1] == "00") {
      return "${timePeriods[0]}h";
    } else {
      return "${timePeriods[0]}h ${timePeriods[1]}m";
    }
  }

  @override
  Widget build(BuildContext context) {
    final phoneWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(7),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed("detailPage/$recipeId");
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
            color: Colors.white,
          ),
          width: phoneWidth * 0.35,
          padding: EdgeInsets.all(4),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(3, 3)),
                    color: Colors.purple[300],
                  ),
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
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: recipeImagePath != null
                      ? FadeInImage(
                          fit: BoxFit.cover,
                          placeholder:
                              AssetImage(circularProgressIndicatorSmall),
                          image: FileImage(File(recipeImagePath)),
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
                        flex: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(3, 3)),
                            color: Colors.purple[300],
                          ),
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
                        flex: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(3, 3)),
                            color: Colors.purple[300],
                          ),
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
                        flex: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(3, 3)),
                            color: Colors.purple[300],
                          ),
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
