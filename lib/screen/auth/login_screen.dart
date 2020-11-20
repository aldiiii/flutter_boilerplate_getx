import 'package:starter_kit_app/constants/routers.dart';
import 'package:starter_kit_app/controllers/auth_controller.dart';
import 'package:starter_kit_app/utils/validator.dart';
import 'package:starter_kit_app/widgets/button/image_button.dart';
import 'package:starter_kit_app/widgets/button/label_button.dart';
import 'package:starter_kit_app/widgets/button/primary_button.dart';
import 'package:starter_kit_app/widgets/form/form_input.dart';
import 'package:starter_kit_app/widgets/horizontal_line_text/horizontal_line_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:starter_kit_app/localizations.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // LogoGraphicHeader(),
                Text(
                  labels?.auth?.loginTitle,
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
                  onPressed: () async {
                    authController.signInGoogle();
                  },
                ),
                // SizedBox(height: 16.0),
                // ImagesButton(
                //   labelText: '${labels?.auth?.loginWithButton} Facebook',
                //   color: Colors.white,
                //   bg: Color(0xff1163D1),
                //   image: SvgPicture.asset('assets/logo/facebook.svg'),
                //   onPressed: () async {
                //     authController.loginWithFacebook(context);
                //   },
                // ),
                SizedBox(height: 24.0),
                HorizontalLineText(
                  text: Text(
                    labels?.auth?.loginWith,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        fontWeight: FontWeight.w500),
                  ),
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                ),
                SizedBox(height: 15.0),
                Text(labels?.auth?.emailFormField,
                    style: theme.textTheme.subtitle1),
                SizedBox(height: 10),
                FormInput(
                  controller: authController.emailController,
                  hintText: labels?.auth?.emailPlaceholder,
                  validator: Validator(labels).email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                      authController.emailController.text = value,
                ),
                SizedBox(height: 24.0),
                Text(labels?.auth?.passwordFormField,
                    style: theme.textTheme.subtitle1),
                SizedBox(height: 10.0),
                Obx(
                  () => FormInput(
                    controller: authController.passwordController,
                    validator: Validator(labels).password,
                    hintText: labels?.auth?.passwordPlaceholder,
                    obscureText: authController.password.value ? false : true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.passwordController.text = value,
                    maxLines: 1,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: authController.password.value
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      onPressed: () => authController.showPassword(),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                PrimaryButton(
                    labelText: labels?.auth?.loginButton,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState.validate()) {
                        authController.signInWithEmailAndPassword();
                      }
                    }),
                SizedBox(height: 6.0),
                LabelButton(
                  // labelText: labels?.auth?.resetPasswordLabelButton,
                  labelText: labels?.auth?.resetPasswordLabelButton,
                  textStyle: theme.textTheme.bodyText2,
                  // onPressed: () => Get.to(ResetPasswordUI()),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(labels?.auth?.dontHaveAccount),
                        SizedBox(width: 3),
                        InkWell(
                          child: Text(
                            labels?.auth?.registerNowButton,
                            style: TextStyle(color: Color(0xff1F76F8)),
                          ),
                          onTap: () {
                            Get.toNamed(Routers.register);
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
