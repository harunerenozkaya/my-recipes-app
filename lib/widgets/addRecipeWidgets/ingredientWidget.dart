import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class IngredientWidget extends StatelessWidget {
  String indgredientName;
  String ingredientUnit;
  String ingredientAmount;
  int index;
  List<Map> ingredients = [];
  Function updateState;

  IngredientWidget(this.indgredientName, this.ingredientUnit,
      this.ingredientAmount, this.index, this.ingredients, this.updateState);

  @override
  Widget build(BuildContext context) {
    double phoneHeight = MediaQuery.of(context).size.height;
    double phoneWidth = MediaQuery.of(context).size.width;
    return Container(
      height: phoneHeight * 0.06,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.green,
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
                updateState();
              },
              child: Container(
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  size: phoneHeight * 0.06,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
