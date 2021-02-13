import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AddPhotoWidget extends StatelessWidget {
  const AddPhotoWidget({
    Key key,
    @required this.phoneHeight,
  }) : super(key: key);

  final double phoneHeight;

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
                  style: TextStyle(fontSize: phoneHeight * 0.027),
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
                  )),
            )
          ],
        ),
      ),
      Container(
        height: phoneHeight * 0.05,
        child: RaisedButton(
          shape: Border.all(width: 3),
          color: Color.fromARGB(255, 252, 242, 249),
          child: Text("Add Photo"),
          onPressed: () {},
        ),
      ),
    ]);
  }
}
