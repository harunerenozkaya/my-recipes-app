import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myRecipes/widgets/editRecipeWidgets/photoWidgetEdited.dart';

import '../../app_localization.dart';

// ignore: must_be_immutable
class EditPhotoWidget extends StatefulWidget {
  final double phoneHeight;
  final Function getPhotos;
  List<String> imagesPath;

  EditPhotoWidget(this.phoneHeight, this.getPhotos, this.imagesPath);

  @override
  _EditPhotoWidgetState createState() => _EditPhotoWidgetState();
}

class _EditPhotoWidgetState extends State<EditPhotoWidget> {
  List<String> imagesPath;
  final _picker = ImagePicker();

  // ignore: must_call_super
  initState() {
    imagesPath = widget.imagesPath.toList();
    // Tarifin zaten var olan verilerini edit page'deki boş verilere upload eder.
    widget.getPhotos(imagesPath);
  }

  _updateState() {
    setState(() {});
  }

  // Kamera'dan resim çeker
  _imgFromCamera() async {
    PickedFile pick =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    if (pick != null) {
      setState(
        () {
          // Image'yi path listesine kaydeder.
          imagesPath.add(pick.path);
          // Path listesini günceller
          widget.getPhotos(imagesPath);
        },
      );
    }
  }

  // Galeriden resim alır.
  _imgFromGallery() async {
    PickedFile pick =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    if (pick != null) {
      setState(
        () {
          // Image'yi path listesine kaydeder.
          imagesPath.add(pick.path);
          // Path listesini günceller
          widget.getPhotos(imagesPath);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
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
                      itemBuilder: (context, index) => PhotoWidgetEdited(
                          index, _updateState, widget.getPhotos, imagesPath),
                      itemCount: imagesPath.length),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: widget.phoneHeight * 0.05,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                side: BorderSide(
                    color: Color.fromARGB(255, 232, 147, 148), width: 3)),
            color: Color.fromARGB(255, 255, 255, 255),
            child: Text(DemoLocalizations.of(context).translate("add_photo")),
            onPressed: () => _showPicker(context),
          ),
        ),
      ],
    );
  }

  // Aşağıdan Kamera'dan mı Galeri'den mi resim seçileceğini soran kutucuk açar
  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title:
                      Text(DemoLocalizations.of(context).translate("gallery")),
                  onTap: () {
                    _imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title:
                      Text(DemoLocalizations.of(context).translate("camera")),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
