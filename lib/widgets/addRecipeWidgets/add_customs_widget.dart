import 'package:flutter/material.dart';

class AddCustomsWidget extends StatelessWidget {
  const AddCustomsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
