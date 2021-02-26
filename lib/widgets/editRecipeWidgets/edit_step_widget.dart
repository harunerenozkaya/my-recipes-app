import 'package:flutter/material.dart';
import 'package:myRecipes/widgets/editRecipeWidgets/stepWidgetEdited.dart';

import '../../app_localization.dart';

// ignore: must_be_immutable
class EditStepsWidget extends StatefulWidget {
  final double phoneHeight;
  final Function getStep;
  List<String> steps;
  EditStepsWidget(this.phoneHeight, this.getStep, this.steps);

  @override
  _EditStepsWidgetState createState() => _EditStepsWidgetState();
}

class _EditStepsWidgetState extends State<EditStepsWidget> {
  List<String> steps = [];
  String step = "";

  // ignore: must_call_super
  initState() {
    steps = widget.steps.toList();
    widget.getStep(steps);
  }

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
                    DemoLocalizations.of(context).translate("steps_title"),
                    style: TextStyle(fontSize: widget.phoneHeight * 0.03),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.fromLTRB(phoneWidth * 0.015,
                      widget.phoneHeight * 0.01, phoneWidth * 0.25, 0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 208, 222, 229),
                    borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
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
                side: BorderSide(
                    color: Color.fromARGB(255, 232, 147, 148), width: 3)),
            color: Color.fromARGB(255, 255, 255, 255),
            child: Text(DemoLocalizations.of(context).translate("add_steps")),
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
                color: Color.fromARGB(255, 220, 220, 220),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(DemoLocalizations.of(context).translate("cancel")),
              ),
              RaisedButton(
                onPressed: () => addNewStepFunction(),
                child: Text(DemoLocalizations.of(context).translate("add")),
                color: Color.fromARGB(255, 232, 147, 148),
              ),
            ],
            title: Text(
                DemoLocalizations.of(context).translate("alert_add_new_step")),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) => step = value,
                  maxLength: 50,
                  cursorHeight: 30,
                  decoration: InputDecoration(
                      labelText: DemoLocalizations.of(context)
                          .translate("step_description"),
                      hintText: DemoLocalizations.of(context)
                          .translate("step_description"),
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
            DemoLocalizations.of(context).translate("step_name_cant_blank"),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 232, 147, 148),
          actions: [
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(DemoLocalizations.of(context).translate("okay")),
              color: Colors.white,
            ),
          ],
        ),
      );
    }
  }
}
