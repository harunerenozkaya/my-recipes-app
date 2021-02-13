import 'package:flutter/material.dart';
import 'package:myRecipes/widgets/addRecipeWidgets/add_customs_widget.dart';
import 'package:myRecipes/widgets/addRecipeWidgets/add_ingredients_widget.dart';
import 'package:myRecipes/widgets/addRecipeWidgets/add_photo_widget.dart';
import 'package:myRecipes/widgets/addRecipeWidgets/add_step_widget.dart';

class AddNewRecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.orange,
        height: phoneHeight * 0.06,
        child: Row(
          children: [
            Expanded(
              child: RaisedButton(
                color: Colors.yellow,
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/");
                },
                child: Container(
                  child: Center(
                    child: Text("Abort"),
                  ),
                ),
              ),
            ),
            Expanded(
              child: RaisedButton(
                color: Colors.red,
                onPressed: () {},
                child: Container(
                  child: Center(
                    child: Text("Okay"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 252, 242, 249),
      appBar: AppBar(
        title: Text(
          "Add New Recipe",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: AddPhotoWidget(phoneHeight: phoneHeight),
            ),
            Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 6,
              child: AddIngredientsWidget(phoneHeight: phoneHeight),
            ),
            Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 6,
              child: AddStepsWidget(phoneHeight: phoneHeight),
            ),
            Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 1,
              child: AddCustomsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
