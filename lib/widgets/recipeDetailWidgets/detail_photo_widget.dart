import 'package:flutter/material.dart';
import 'package:myRecipes/widgets/recipeDetailWidgets/photoWidgetDetailed.dart';

import '../../app_localization.dart';

// ignore: must_be_immutable
class DetailPhotoWidget extends StatefulWidget {
  List<String> imagesPath = [];
  final double phoneHeight;

  DetailPhotoWidget(this.imagesPath, this.phoneHeight, {Key key});

  @override
  _DetailPhotoWidgetState createState() => _DetailPhotoWidgetState();
}

class _DetailPhotoWidgetState extends State<DetailPhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                DemoLocalizations.of(context).translate("photos_title"),
                style: TextStyle(fontSize: widget.phoneHeight * 0.027),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 208, 222, 229),
                borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return PhotoWidgetDetailed(widget.imagesPath[index], index);
                  },
                  itemCount: widget.imagesPath.length),
            ),
          ),
        ],
      ),
    );
  }
}
