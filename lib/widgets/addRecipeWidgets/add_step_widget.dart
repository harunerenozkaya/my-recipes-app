import 'package:flutter/material.dart';

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
  String step;

  void updateStateMainWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  decoration: BoxDecoration(
                    border: Border.all(width: 3),
                    color: Color.fromARGB(255, 235, 172, 215),
                  ),
                  child: ListView.separated(
                      itemBuilder: (context, index) =>
                          Text("${index + 1} ) ${steps[index]}"),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: steps.length),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: widget.phoneHeight * 0.19),
          alignment: Alignment.topRight,
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
    steps.add(step);
    Navigator.pop(context);
    updateStateMainWidget();
  }
}
