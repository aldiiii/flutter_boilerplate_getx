import 'package:flutter/material.dart';

/*
FormInput(
                controller: _url,
                labelText: 'Post URL',
                validator: Validator.notEmpty,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                onChanged: (value) => print('changed'),
                onSaved: (value) => print('implement me'),
              ),
*/

class FormInput extends StatelessWidget {
  FormInput(
      {this.controller,
      this.labelText,
      this.hintText,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.suffixIcon,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines,
      this.onChanged,
      this.onSaved});

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String Function(String) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget suffixIcon;
  final int minLines;
  final int maxLines;
  final void Function(String) onChanged;
  final void Function(String) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          // fillColor: Colors.black45, //Palette.inputFillColor,
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixIcon),
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
      textInputAction: TextInputAction.next,
    );
  }
}
