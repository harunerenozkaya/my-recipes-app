import 'package:flutter/material.dart';

class RecipeBox extends StatelessWidget {
  final String recipeName;
  final String recipeImageLink;
  final String hardness;
  final String time;
  final String money;

  RecipeBox(this.recipeName, this.recipeImageLink, this.hardness, this.time,
      this.money);

  @override
  Widget build(BuildContext context) {
    final phoneWidth = MediaQuery.of(context).size.width;

    return Container(
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
            child: Container(
              padding: EdgeInsets.all(2),
              child: Image.network(
                "$recipeImageLink",
                fit: BoxFit.fill,
              ),
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
                      child: Center(child: Text("$hardness")),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 7,
                      child: Container(
                          color: Colors.yellow,
                          child: Center(child: Text("$time")))),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 7,
                      child: Container(
                          color: Colors.blue,
                          child: Center(child: Text("$money"))))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
