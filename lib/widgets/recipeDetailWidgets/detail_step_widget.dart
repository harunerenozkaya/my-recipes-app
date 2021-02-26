import 'package:flutter/material.dart';
import 'package:myRecipes/widgets/recipeDetailWidgets/stepWidgetDetailed.dart';

import '../../app_localization.dart';

class DetailStepsWidget extends StatefulWidget {
  final List<String> steps;
  final double phoneHeight;

  DetailStepsWidget(
    this.steps,
    this.phoneHeight, {
    Key key,
  });

  @override
  _DetailStepsWidgetState createState() => _DetailStepsWidgetState();
}

class _DetailStepsWidgetState extends State<DetailStepsWidget> {
  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                DemoLocalizations.of(context).translate("steps_title"),
                style: TextStyle(fontSize: widget.phoneHeight * 0.03),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.fromLTRB(phoneWidth * 0.013,
                  widget.phoneHeight * 0.01, phoneWidth * 0.03, 0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 208, 222, 229),
                borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
              ),
              child: ListView.separated(
                  primary: false,
                  itemBuilder: (context, index) =>
                      StepWidgetDetailed(widget.steps[index], index),
                  separatorBuilder: (context, index) => Container(
                        height: phoneHeight * 0.008,
                      ),
                  itemCount: widget.steps.length),
            ),
          ),
        ],
      ),
    );
  }
}
