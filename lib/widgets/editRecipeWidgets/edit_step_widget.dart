import 'package:flutter/material.dart';
import 'package:myRecipes/widgets/editRecipeWidgets/stepWidgetEdited.dart';

class EditStepsWidget extends StatefulWidget {
  EditStepsWidget({
    Key key,
    @required this.phoneHeight,
    @required this.getStep,
  }) : super(key: key);

  final double phoneHeight;
  final Function getStep;

  @override
  _EditStepsWidgetState createState() => _EditStepsWidgetState();
}

class _EditStepsWidgetState extends State<EditStepsWidget> {
  List<String> steps = [];
  String step = "";

  void updateStateMainWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Steps",
                    style: TextStyle(fontSize: widget.phoneHeight * 0.03),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.fromLTRB(phoneWidth * 0.01,
                      widget.phoneHeight * 0.005, phoneWidth * 0.25, 0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 235, 172, 215),
                    borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                    border: Border.all(color: Colors.purple[300], width: 3),
                  ),
                  child: ListView.separated(
                      primary: false,
                      itemBuilder: (context, index) => StepWidgetEdited(
                          steps[index],
                          index,
                          steps,
                          updateStateMainWidget,
                          widget.getStep),
                      separatorBuilder: (context, index) => Container(
                            height: phoneHeight * 0.008,
                          ),
                      itemCount: steps.length),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: phoneWidth * 0.25,
          height: phoneHeight * 0.05,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                side: BorderSide(color: Colors.purple[300], width: 3)),
            color: Color.fromARGB(255, 252, 242, 249),
            child: Text("Add Step"),
            onPressed: () {
              showStepDialog(context);
            },
          ),
        ),
      ],
    );
  }

  Future showStepDialog(BuildContext context) {
    return showDialog(
      context: (context),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              RaisedButton(
                onPressed: () => addNewStepFunction(),
                child: Text("Add"),
                color: Color.fromARGB(255, 235, 172, 215),
              ),
            ],
            title: Text("Add New Step"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) => step = value,
                  maxLength: 50,
                  cursorHeight: 30,
                  decoration: InputDecoration(
                      labelText: "Step Description",
                      hintText: "Step Description",
                      border: OutlineInputBorder(gapPadding: 10)),
                ),
                SizedBox(
                  height: widget.phoneHeight * 0.01,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void addNewStepFunction() {
    if (step != "") {
      steps.add(step);
      widget.getStep(steps);
      Navigator.pop(context);
      updateStateMainWidget();
      step = "";
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            "Step can't be blank.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
          actions: [
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Okay"),
              color: Colors.white,
            ),
          ],
        ),
      );
    }
  }
}
