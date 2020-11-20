import 'package:get/get.dart';
import 'package:starter_kit_app/controllers/register_controller.dart';
import 'package:starter_kit_app/utils/validator.dart';
import 'package:starter_kit_app/widgets/button/image_button.dart';
import 'package:starter_kit_app/widgets/button/primary_button.dart';
import 'package:starter_kit_app/widgets/form/form_input.dart';
import 'package:starter_kit_app/widgets/horizontal_line_text/horizontal_line_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_kit_app/localizations.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController registerController = RegisterController.to;
  final GlobalKey<FormState> _formRegisterKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Form(
          key: _formRegisterKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      labels?.auth?.registerTitle,
                      style: theme.textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.0),
                    ImagesButton(
                      labelText: '${labels?.auth?.loginWithButton} Google',
                      image: SvgPicture.asset('assets/logo/google.svg'),
                      borderSide: BorderSide(
                        color: Color(0xff757575),
                      ),
                      onPressed: () {
                        registerController.signUnGoogle();
                      },
                    ),
                    // SizedBox(height: 16.0),
                    // ImagesButton(
                    //   labelText: '${labels?.auth?.loginWithButton} Facebook',
                    //   color: Colors.white,
                    //   bg: Color(0xff1163D1),
                    //   image: SvgPicture.asset('assets/logo/facebook.svg'),
                    //   onPressed: () {},
                    // ),
                    SizedBox(height: 24.0),
                    HorizontalLineText(
                      text: Text(
                        labels?.auth?.registerWith,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            fontWeight: FontWeight.w500),
                      ),
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                    SizedBox(height: 15.0),
                    Text(labels?.auth?.fullNameFormField,
                        style: theme.textTheme.subtitle1),
                    SizedBox(height: 10),
                    // form input
                    FormInput(
                      controller: registerController.fullNameController,
                      hintText: labels?.auth?.fullNamePlaceholder,
                      validator: Validator(labels).name,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => null,
                    ),
                    SizedBox(height: 24.0),
                    Text(labels?.auth?.phoneFormField,
                        style: theme.textTheme.subtitle1),
                    SizedBox(height: 10),
                    FormInput(
                      controller: registerController.phoneController,
                      hintText: labels?.auth?.phonePlaceholder,
                      validator: Validator(labels).number,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => null,
                    ),
                    SizedBox(height: 24.0),
                    Text(labels?.auth?.emailFormField,
                        style: theme.textTheme.subtitle1),
                    SizedBox(height: 10),
                    FormInput(
                      controller: registerController.emailController,
                      hintText: labels?.auth?.emailPlaceholder,
                      validator: Validator(labels).email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => null,
                    ),
                    SizedBox(height: 24.0),
                    Text(labels?.auth?.passwordFormField,
                        style: theme.textTheme.subtitle1),
                    SizedBox(height: 10.0),
                    Obx(
                      () => FormInput(
                        controller: registerController.passwordController,
                        hintText: labels?.auth?.passwordPlaceholder,
                        validator: Validator(labels).password,
                        obscureText:
                            registerController.password.value ? false : true,
                        onChanged: (value) => null,
                        maxLines: 1,
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: registerController.password.value
                                ? Colors.blue
                                : Colors.grey,
                          ),
                          onPressed: () => registerController.showPassword(),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.0),
                    Text(labels?.auth?.passwordConfirmFormField,
                        style: theme.textTheme.subtitle1),
                    SizedBox(height: 10.0),
                    Obx(
                      () => FormInput(
                        controller:
                            registerController.passwordConfirmController,
                        hintText: labels?.auth?.passwordConfirmPlaceholder,
                        validator: (value) {
                          return Validator(labels).passwordConfirm(value,
                              registerController.passwordController.text);
                        },
                        obscureText: registerController.passwordConfirm.value
                            ? false
                            : true,
                        onChanged: (value) => null,
                        maxLines: 1,
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: registerController.passwordConfirm.value
                                ? Colors.blue
                                : Colors.grey,
                          ),
                          onPressed: () =>
                              registerController.showPasswordConfirm(),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    PrimaryButton(
                        labelText: labels?.auth?.registerButton,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_formRegisterKey.currentState.validate()) {
                            registerController.signUpNormal();
                          }
                        }),
                    SizedBox(height: 30.0)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
