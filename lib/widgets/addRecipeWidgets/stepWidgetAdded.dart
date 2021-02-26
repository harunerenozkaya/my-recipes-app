import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

// ignore: must_be_immutable
class StepWidget extends StatelessWidget {
  final String stepDescription;
  final int index;
  List steps = [];
  final Function updateState;
  final Function getStep;

  StepWidget(this.stepDescription, this.index, this.steps, this.updateState,
      this.getStep);

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
                color: Color.fromARGB(255, 232, 147, 148),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  "${index + 1}",
                  style: TextStyle(fontSize: 20),
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
                "$stepDescription",
                maxLines: 2,
                minFontSize: 10,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                // Step box'ı silme
                steps.removeAt(index);
                getStep(steps);
                updateState();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 232, 147, 148),
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
