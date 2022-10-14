import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String title;
  Function changeBoard;
  ButtonWidget(this.title, this.changeBoard);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        changeBoard();
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
