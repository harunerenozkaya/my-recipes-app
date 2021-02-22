import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'dart:io';

// ignore: must_be_immutable
class PhotoWidgetDetailed extends StatelessWidget {
  final String imagePath;
  final int index;

  PhotoWidgetDetailed(this.imagePath, this.index);

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(3),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            color: Colors.white,
            child: FadeInImage(
              width: phoneWidth * 0.3,
              height: phoneHeight * 0.145,
              fit: BoxFit.cover,
              image: FileImage(
                File(imagePath),
              ),
              placeholder: AssetImage(circularProgressIndicatorSmall),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                0, phoneHeight * 0.007, phoneWidth * 0.013, 0),
            height: phoneHeight * 0.03,
            child: GestureDetector(
              onTap: () => zoomImage(context),
              child: Container(
                color: Colors.purple[300],
                child: Icon(
                  Icons.search,
                  size: phoneHeight * 0.03,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  zoomImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        contentPadding: EdgeInsets.all(4),
        content: Image.file(
          File(imagePath),
        ),
      ),
    );
  }
}
