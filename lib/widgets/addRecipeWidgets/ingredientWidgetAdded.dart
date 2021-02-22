import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

// ignore: must_be_immutable
class IngredientWidget extends StatelessWidget {
  final String indgredientName;
  final String ingredientUnit;
  final String ingredientAmount;
  final int index;
  List<Map> ingredients = [];
  final Function updateState;
  final Function getIngredient;

  IngredientWidget(
      this.indgredientName,
      this.ingredientUnit,
      this.ingredientAmount,
      this.index,
      this.ingredients,
      this.updateState,
      this.getIngredient);

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
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
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
            flex: 4,
            child: Container(
              alignment: Alignment.centerLeft,
              height: phoneHeight * 0.06,
              color: Colors.white,
              padding: EdgeInsets.only(left: phoneWidth * 0.01),
              child: AutoSizeText(
                "$indgredientName",
                maxLines: 2,
                minFontSize: 10,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                // Ingredient box'ı silme
                ingredients.removeAt(index);
                getIngredient(ingredients);
                updateState();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple[300],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Icon(
                  Icons.delete,
                  size: phoneHeight * 0.06,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
