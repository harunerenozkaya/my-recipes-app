import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

// ignore: must_be_immutable
class StepWidgetDetailed extends StatelessWidget {
  final String stepDescription;
  final int index;

  StepWidgetDetailed(this.stepDescription, this.index);

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
                child: Text(
                  "${index + 1}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.centerLeft,
              height: phoneHeight * 0.06,
              padding: EdgeInsets.only(left: phoneWidth * 0.01),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: AutoSizeText(
                "$stepDescription",
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
