import 'package:flutter/material.dart';
import 'dart:io';

class PhotoWidget extends StatelessWidget {
  List<File> _images;
  int index;
  Function _updateState;

  PhotoWidget(this._images, this.index, this._updateState);

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          child: Image.file(_images[index]),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              0, phoneHeight * 0.007, phoneWidth * 0.013, 0),
          height: phoneHeight * 0.03,
          child: GestureDetector(
            onTap: () {
              // Ingredient box'ı silme
              _images.removeAt(index);
              _updateState();
            },
            child: Container(
              color: Colors.purple[300],
              child: Icon(
                Icons.delete,
                size: phoneHeight * 0.03,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
