import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class StepWidget extends StatelessWidget {
  String stepDescription;
  int index;
  List steps = [];
  Function updateState;

  StepWidget(this.stepDescription, this.index, this.steps, this.updateState);

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
