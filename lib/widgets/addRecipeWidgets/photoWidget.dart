import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// ignore: must_be_immutable
class PhotoWidget extends StatelessWidget {
  List<File> _images;
  int index;
  Function _updateState;
  Function getPhotos;
  List<String> imagesPath;

  PhotoWidget(this._images, this.index, this._updateState, this.getPhotos,
      this.imagesPath);

  // Uygulamanın path'ini verir.
  Future getPath() async {
    Directory pathD = await getApplicationDocumentsDirectory();
    return pathD.path;
  }

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
              // Kaldırılmış resmi widget litesinden siler.
              _images.removeAt(index);

              //Kaldırılmış resmin path'ını path listesinden siler
              imagesPath.removeAt(index);

              //Main recipe screen'teki image path listesini item silindikten sonraki hali olarak günceller
              getPhotos(imagesPath);
              //Yeni recipe ekleme ekranının statesini günceller
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
