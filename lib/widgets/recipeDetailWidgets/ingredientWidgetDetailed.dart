import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

// ignore: must_be_immutable
class IngredientWidgetDetailed extends StatelessWidget {
  final String indgredientName;
  final String ingredientUnit;
  final String ingredientAmount;
  final int index;

  IngredientWidgetDetailed(
    this.indgredientName,
    this.ingredientUnit,
    this.ingredientAmount,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    double phoneHeight = MediaQuery.of(context).size.height;
    double phoneWidth = MediaQuery.of(context).size.width;
    return Container(
      height: phoneHeight * 0.06,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.purple[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )),
              child: Center(
                child: AutoSizeText(
                  "$ingredientAmount $ingredientUnit",
                  minFontSize: 10,
                  maxLines: 1,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.only(left: phoneWidth * 0.015),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              height: phoneHeight * 0.06,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                "$indgredientName",
                maxLines: 2,
                minFontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
