import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myRecipes/widgets/editRecipeWidgets/photoWidgetEdited.dart';

class EditPhotoWidget extends StatefulWidget {
  const EditPhotoWidget({
    Key key,
    @required this.phoneHeight,
    @required this.getPhotos,
  }) : super(key: key);

  final double phoneHeight;
  final Function getPhotos;

  @override
  _EditPhotoWidgetState createState() => _EditPhotoWidgetState();
}

class _EditPhotoWidgetState extends State<EditPhotoWidget> {
  List<String> imagesPath = [];
  final _picker = ImagePicker();

  _updateState() {
    setState(() {});
  }

  _imgFromCamera() async {
    PickedFile pick =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    print(pick.path);

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

  _imgFromGallery() async {
    PickedFile pick =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    print(pick.path);

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
                    "Photos",
                    style: TextStyle(fontSize: widget.phoneHeight * 0.027),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 235, 172, 215),
                    borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                    border: Border.all(color: Colors.purple[300], width: 3),
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
                side: BorderSide(color: Colors.purple[300], width: 3)),
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
