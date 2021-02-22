import 'package:flutter/material.dart';
import 'ingredientWidgetDetailed.dart';

class DetailIngredientsWidget extends StatefulWidget {
  final double phoneHeight;
  final List<Map> ingredients;

  DetailIngredientsWidget(
    this.ingredients,
    this.phoneHeight, {
    Key key,
  });

  @override
  _DetailIngredientsWidgetState createState() =>
      _DetailIngredientsWidgetState();
}

class _DetailIngredientsWidgetState extends State<DetailIngredientsWidget> {
  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ingredients",
                style: TextStyle(fontSize: widget.phoneHeight * 0.03),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.fromLTRB(phoneWidth * 0.01,
                  widget.phoneHeight * 0.005, phoneWidth * 0.03, 0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 235, 172, 215),
                borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                border: Border.all(color: Colors.purple[300], width: 3),
              ),
              child: ListView.separated(
                  primary: false,
                  itemBuilder: (context, index) {
                    String ingredientName =
                        widget.ingredients[index].values.toList()[0];
                    String ingredientAmount =
                        widget.ingredients[index].values.toList()[1];
                    String ingredientUnit =
                        widget.ingredients[index].values.toList()[2];
                    return IngredientWidgetDetailed(ingredientName,
                        ingredientUnit, ingredientAmount, index);
                  },
                  separatorBuilder: (context, index) => Container(
                        height: widget.phoneHeight * 0.008,
                      ),
                  itemCount: widget.ingredients.length),
            ),
          ),
        ],
      ),
    );
  }
}
