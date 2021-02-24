import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

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
  String parseTime(String time) {
    List timePeriods = time.split(":");

    if (timePeriods[0] == "0") {
      return "      ${timePeriods[1]}m";
    } else if (timePeriods[0] != "0" && timePeriods[1] == "00") {
      return "      ${timePeriods[0]}h";
    } else {
      return "   ${timePeriods[0]}h ${timePeriods[1]}m";
    }
  }

  @override
  Widget build(BuildContext context) {
    double phoneHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                  color: Color.fromARGB(255, 252, 242, 249),
                  border: Border.all(
                    width: 3,
                    color: Colors.purple[300],
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
                      child: AutoSizeText(
                        parseTime(widget.recipeDuration),
                        style: TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                  color: Color.fromARGB(255, 252, 242, 249),
                  border: Border.all(
                    width: 3,
                    color: Colors.purple[300],
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
                      child: AutoSizeText(
                        "  ${widget.category}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                  color: Color.fromARGB(255, 252, 242, 249),
                  border: Border.all(
                    width: 3,
                    color: Colors.purple[300],
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
                      child: AutoSizeText(
                        "       ${widget.price}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
