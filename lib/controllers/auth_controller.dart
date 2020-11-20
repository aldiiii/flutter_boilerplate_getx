import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:starter_kit_app/constants/local_storage.dart';
import 'package:starter_kit_app/constants/routers.dart';
import 'package:starter_kit_app/data/repositories/auth_repository.dart';
import 'package:starter_kit_app/utils/exceptions/server_exception.dart';
import 'package:starter_kit_app/utils/services/local_storage.dart';
import 'package:starter_kit_app/widgets/auth_webview/auth_webview.dart';
import 'package:starter_kit_app/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  AuthController(this._storage, this._authRepository);
  final LocalStorage _storage;
  final AuthRepository _authRepository;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  static AuthController to = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String token;
  final isLogged = true.obs;

  final password = false.obs;

  @override
  void onInit() async {
    // with the ever worker, whenever the isLodded variable changes, handleAuthChanged is called
    // ever(isLogged, fireRoute);
    super.onInit();
    token = _storage.read(LocalStore.token) ?? null;
    // _storage.remove(LocalStore.token);
    print('token ' + token.toString());
    if (token == null) {
      isLogged.value = false;
    }

    // print(isLogged.value);
  }

  @override
  void onClose() {
    emailController?.dispose();
    passwordController?.dispose();
    super.onClose();
  }

  // handle auth checking
  // fireRoute(logged) {
  //   print('logged' + logged.toString());
  //   if (!logged) {
  //     Get.toNamed(Routers.home);
  //   }
  // }

  void showPassword() => password.value = !password.value;

  // get account social
  getAccountSocial() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential authResult = await _auth.signInWithCredential(credential);
      final _user = authResult.user;
      return _user;
    } catch (_) {}
  }

  //Method to handle user sign in using email and password
  void signInWithEmailAndPassword() async {
    try {
      showLoadingIndicator();
      final response = await _authRepository.authentication(
          email: emailController.text.trim(),
          password: passwordController.text);

      if (response != null) {
        // save token to local storage
        saveToken(response.token);
        Get.offAllNamed(Routers.home);
      }
    } on ServerException catch (e) {
      print(e);
      Get.snackbar('error', '${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Colors.black54,
          colorText: Get.theme.snackBarTheme.actionTextColor,
          margin: EdgeInsets.all(10.0));
    }
    hideLoadingIndicator();
  }

  // login with google
  Future<void> signInGoogle() async {
    try {
      final _user = await getAccountSocial();

      final data = {
        'uid': _user.uid,
        'name': _user.displayName,
        'email': _user.email,
        'phone': _user.phoneNumber,
        'photo': _user.photoURL
      };

      showLoadingIndicator();

      final response = await _authRepository.authenticationSocial(
          provider: 'google', data: data);

      if (response != null) {
        // save token to local storage
        saveToken(response.token);
        Get.offAllNamed(Routers.home);
      }
    } catch (_) {
      Get.snackbar('error', 'Something wrong',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Colors.black54,
          colorText: Get.theme.snackBarTheme.actionTextColor,
          margin: EdgeInsets.all(10.0));
    }

    hideLoadingIndicator();
  }

  // sign with facebook
  void loginWithFacebook(context) async {
    String clientId = '923847kjsdfksdn';
    String redirectUrl = "https://www.facebook.com/connect/login_success.html";
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AuthWebView(
                selectedUrl:
                    'https://www.facebook.com/dialog/oauth?client_id=$clientId&redirect_uri=$redirectUrl&response_type=token&scope=email,public_profile,',
              ),
          maintainState: true),
    );

    if (result != null) {
      try {
        final facebookAuthCred = FacebookAuthProvider.credential(result);

        await _auth.signInWithCredential(facebookAuthCred);

        Get.offAllNamed(Routers.home);
      } catch (e) {}
    }
  }

  void signOutGoogle() async {
    await _googleSignIn.signOut();
    print("User Sign Out");
  }

  void saveToken(String token) async {
    await _storage.write(LocalStore.token, token);
    this.token = token;
    isLogged.value = true;
    update();
  }

  Future<void> logout() async {
    await _storage.remove(LocalStore.token);
    token = null;
    isLogged.value = false;
    signOutGoogle();
    update();
  }
}
