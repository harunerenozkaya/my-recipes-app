import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'dart:io';

// ignore: must_be_immutable
class PhotoWidget extends StatelessWidget {
  int index;
  Function _updateState;
  Function getPhotos;
  List<String> imagesPath;

  PhotoWidget(this.index, this._updateState, this.getPhotos, this.imagesPath);

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
                File(imagesPath[index]),
              ),
              placeholder: AssetImage(circularProgressIndicatorSmall),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                0, phoneHeight * 0.007, phoneWidth * 0.013, 0),
            height: phoneHeight * 0.03,
            child: GestureDetector(
              onTap: () async {
                // Ingredient box'ı silme

                //Fotoyu dosyalardan silme
                File deletingImage = File(imagesPath[index]);
                await deletingImage.delete();

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
      ),
    );
  }
}
