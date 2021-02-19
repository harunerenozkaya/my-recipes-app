import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class RecipeBox extends StatelessWidget {
  final String recipeName;
  final String recipeImageLink;
  final String category;
  final String time;
  final String money;

  RecipeBox(this.recipeName, this.recipeImageLink, this.category, this.time,
      this.money);

  var path;

  getPath() async {
    var directory = await getApplicationDocumentsDirectory();
    path = directory.path;
  }

  @override
  Widget build(BuildContext context) {
    final phoneWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Hive.box("recipes").values.toList().forEach((element) {
          print(element.isFavorite);
        });
      },
      child: Container(
        width: phoneWidth * 0.35,
        color: Colors.white,
        padding: EdgeInsets.all(3),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black,
                child: Center(
                    child: Text(
                  "$recipeName",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            Expanded(
              flex: 7,
              child: FutureBuilder(
                future: getPath(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      return Container(
                        padding: EdgeInsets.all(2),
                        child: Image.file(
                          File("$path/$recipeImageLink.png"),
                          fit: BoxFit.fill,
                        ),
                      );

                    case ConnectionState.done:
                      return Container(
                        padding: EdgeInsets.all(2),
                        child: Image.file(
                          File("$path/$recipeImageLink"),
                          fit: BoxFit.fill,
                        ),
                      );
                    case ConnectionState.none:
                      return Container(
                        padding: EdgeInsets.all(2),
                      );
                    case ConnectionState.waiting:
                      return Container(
                        padding: EdgeInsets.all(2),
                      );
                  }
                },
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
                        color: Colors.green,
                        child: Center(
                          child: Text("$category"),
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
                        color: Colors.yellow,
                        child: Center(
                          child: Text("$time"),
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
                        color: Colors.blue,
                        child: Center(
                          child: Text("$money"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
