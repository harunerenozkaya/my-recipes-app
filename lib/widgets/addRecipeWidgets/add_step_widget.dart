import 'package:flutter/material.dart';
import 'package:myRecipes/widgets/addRecipeWidgets/stepWidget.dart';

class AddStepsWidget extends StatefulWidget {
  AddStepsWidget({
    Key key,
    @required this.phoneHeight,
  }) : super(key: key);

  final double phoneHeight;

  @override
  _AddStepsWidgetState createState() => _AddStepsWidgetState();
}

class _AddStepsWidgetState extends State<AddStepsWidget> {
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
                    border: Border.all(width: 3),
                    color: Color.fromARGB(255, 235, 172, 215),
                  ),
                  child: ListView.separated(
                      primary: false,
                      itemBuilder: (context, index) => StepWidget(
                          steps[index], index, steps, updateStateMainWidget),
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
            shape: Border.all(width: 3),
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
          return SingleChildScrollView(
            child: AlertDialog(
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
            ),
          );
        },
      ),
    );
  }

  void addNewStepFunction() {
    if (step != "") {
      steps.add(step);
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
            )
          ],
        ),
      );
    }
  }
}
