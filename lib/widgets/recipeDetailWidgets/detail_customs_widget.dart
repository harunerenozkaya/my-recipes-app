import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../app_localization.dart';

class DetailCustomsWidget extends StatefulWidget {
  final String recipeDuration;
  final String category;
  final String price;

  DetailCustomsWidget(
    this.recipeDuration,
    this.category,
    this.price, {
    Key key,
  });

  @override
  _DetailCustomsWidgetState createState() => _DetailCustomsWidgetState();
}

class _DetailCustomsWidgetState extends State<DetailCustomsWidget> {
  // Gelen zaman string'i dağınık olduğu için istediği formata sokar
  String parseTime(String time) {
    List timePeriods = time.split(":");

    if (timePeriods[0] == "0") {
      return "${timePeriods[1]}${DemoLocalizations.of(context).translate("minute_tag")}";
    } else if (timePeriods[0] != "0" && timePeriods[1] == "00") {
      return "${timePeriods[0]}${DemoLocalizations.of(context).translate("hour_tag")}";
    } else {
      return "${timePeriods[0]}${DemoLocalizations.of(context).translate("hour_tag")} ${timePeriods[1]}${DemoLocalizations.of(context).translate("minute_tag")}";
    }
  }

  @override
  Widget build(BuildContext context) {
    double phoneHeight = MediaQuery.of(context).size.height;
    double phoneWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                color: Color.fromARGB(255, 255, 255, 255),
                border: Border.all(
                  width: 3,
                  color: Color.fromARGB(255, 232, 147, 148),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.timer,
                      size: phoneHeight * 0.027,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: phoneWidth > 600.0
                              ? phoneWidth * 0.063
                              : phoneWidth * 0.035),
                      child: AutoSizeText(
                        parseTime(widget.recipeDuration),
                        style: TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                color: Color.fromARGB(255, 255, 255, 255),
                border: Border.all(
                  width: 3,
                  color: Color.fromARGB(255, 232, 147, 148),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.list,
                      size: phoneHeight * 0.027,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: phoneWidth > 600.0
                              ? phoneWidth * 0.03
                              : phoneWidth * 0.00),
                      child: AutoSizeText(
                        "  ${widget.category}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                color: Color.fromARGB(255, 255, 255, 255),
                border: Border.all(
                  width: 3,
                  color: Color.fromARGB(255, 232, 147, 148),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.attach_money,
                      size: phoneHeight * 0.027,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: phoneWidth > 600.0
                              ? phoneWidth * 0.068
                              : phoneWidth * 0.05),
                      child: AutoSizeText(
                        "${widget.price}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
