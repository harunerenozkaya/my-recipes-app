import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:myRecipes/widgets/addRecipeWidgets/photoWidget.dart';

class AddPhotoWidget extends StatefulWidget {
  const AddPhotoWidget({
    Key key,
    @required this.phoneHeight,
  }) : super(key: key);

  final double phoneHeight;

  @override
  _AddPhotoWidgetState createState() => _AddPhotoWidgetState();
}

class _AddPhotoWidgetState extends State<AddPhotoWidget> {
  List<File> _images = [];

  _updateState() {
    setState(() {});
  }

  _imgFromCamera() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 30);
    if (image != null) {
      setState(
        () {
          _images.add(image);
        },
      );
    }
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 30);

    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: [
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
                    itemBuilder: (context, index) =>
                        PhotoWidget(_images, index, _updateState),
                    itemCount: _images.length),
              ),
            )
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
    ]);
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

/*
    child: Center(
                    child: CarouselSlider(
                      options: CarouselOptions(),
                      items: [
                        Container(
                          child: Image.network(
                              "https://imgrosetta.mynet.com.tr/file/9951142/9951142-728xauto.jpg"),
                        ),
                        Container(
                          child: Image.network(
                              "https://im.haberturk.com/2020/04/23/ver1587621896/2655814_414x414.jpg"),
                        )
                      ],
                    ),
                  ),*/
