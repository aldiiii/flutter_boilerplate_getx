import 'package:flutter/material.dart';

/*
ImagesButton(
  labelText: 'label',
    image: Image.asset(
                    'assets/images/animation.png',
                    height: 40.0,
                    width: 40.0,
                  ),
  onPressed: () => print('Submit'),
),
*/

class ImagesButton extends StatelessWidget {
  ImagesButton(
      {this.labelText,
      this.color,
      this.bg,
      this.image,
      this.borderSide,
      this.onPressed});

  final String labelText;
  final Color color;
  final Color bg;
  final image;
  final BorderSide borderSide;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
        side: borderSide ??
            BorderSide(
              color: Colors.transparent,
            ),
      ),
      color: bg ?? Colors.white,
      padding: EdgeInsets.all(15),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          image,
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(labelText,
                style: TextStyle(color: color ?? Color.fromRGBO(0, 0, 0, 0.7))),
          )
        ],
      ),
    );
  }
}
