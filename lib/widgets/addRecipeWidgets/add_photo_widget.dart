import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:myRecipes/widgets/addRecipeWidgets/photoWidget.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

class AddPhotoWidget extends StatefulWidget {
  const AddPhotoWidget({
    Key key,
    @required this.phoneHeight,
    @required this.getPhotos,
  }) : super(key: key);

  final double phoneHeight;
  final Function getPhotos;

  @override
  _AddPhotoWidgetState createState() => _AddPhotoWidgetState();
}

class _AddPhotoWidgetState extends State<AddPhotoWidget> {
  List<File> _images = [];
  List<String> imagesPath = [];

  _updateState() {
    setState(() {});
  }

  _imgFromCamera() async {
    Directory pathD = await getApplicationDocumentsDirectory();
    String path = pathD.path;
    String randomId = getRandomString();

    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 30);
    if (image != null) {
      setState(
        () {
          image.copy('$path/$randomId.png');

          _images.add(image);
          imagesPath.add(randomId);
          widget.getPhotos(imagesPath);
        },
      );
    }
  }

  _imgFromGallery() async {
    Directory pathD = await getApplicationDocumentsDirectory();
    String path = pathD.path;

    String randomIdd = getRandomString();

    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 30);

    if (image != null) {
      setState(
        () {
          // Fotoğrafı dosyalara kaydeder.
          image.copy('$path/$randomIdd.png');
          // Fotoğrafı widget listesine kaydeder
          _images.add(image);
          //Fotoğrafı path listesine kaydeder.
          imagesPath.add(randomIdd);
          // Path listesini günceller
          widget.getPhotos(imagesPath);
        },
      );
    }
  }

  String getRandomString() {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        7,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
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
                    "Photos",
                    style: TextStyle(fontSize: widget.phoneHeight * 0.027),
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
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => PhotoWidget(_images,
                          index, _updateState, widget.getPhotos, imagesPath),
                      itemCount: _images.length),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: widget.phoneHeight * 0.05,
          child: RaisedButton(
            shape: Border.all(width: 3),
            color: Color.fromARGB(255, 252, 242, 249),
            child: Text("Add Photo"),
            onPressed: () => _showPicker(context),
          ),
        ),
      ],
    );
  }

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
                  title: Text('Photo Library'),
                  onTap: () {
                    _imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
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
