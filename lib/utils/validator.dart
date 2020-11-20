import 'package:starter_kit_app/localizations.dart';

class Validator {
  AppLocalizations_Labels labels;
  Validator(this.labels);

  String email(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return labels.validator.email;
    else
      return null;
  }

  String password(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return labels.validator.password;
    else
      return null;
  }

  String passwordConfirm(String value, String passwordInput) {
    final passwordvalidation = password(value);
    if (passwordvalidation != null) {
      return labels.validator.password;
    } else if (value != passwordInput) {
      return 'Not Match';
    } else {
      return null;
    }
  }

  String name(String value) {
    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return labels.validator.name;
    else
      return null;
  }

  String number(String value) {
    Pattern pattern = r'^^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return labels.validator.number;
    else
      return null;
  }

  String amount(String value) {
    Pattern pattern = r'^\d+$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return labels.validator.amount;
    else
      return null;
  }

  String notEmpty(String value) {
    Pattern pattern = r'^\S+$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return labels.validator.notEmpty;
    else
      return null;
  }
}
