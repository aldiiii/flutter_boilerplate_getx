import 'package:flutter/material.dart';

/*
PrimaryButton(
  labelText: 'UPDATE',
  onPressed: () => print('Submit'),
),
*/

class PrimaryButton extends StatelessWidget {
  PrimaryButton({this.labelText, this.onPressed});

  final String labelText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      padding: EdgeInsets.all(18.0),
      child: Text(
        labelText,
      ),
    );
  }
}
