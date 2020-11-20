import 'package:starter_kit_app/constants/urls.dart';
import 'package:starter_kit_app/data/models/profile_model.dart';
import 'package:starter_kit_app/utils/services/http_client.dart';
import 'package:meta/meta.dart';

abstract class AuthRepository {
  Future<ProfileModel> authentication(
      {@required String email, @required String password});

  Future<ProfileModel> authenticationSocial(
      {@required provider, @required data});

  Future<ProfileModel> signUpNormal({@required Map data});
}

class AuthRepositoryImpl extends AuthRepository {
  final HttpClient _client;

  AuthRepositoryImpl(this._client);

  @override
  Future<ProfileModel> authentication(
      {@required String email, @required String password}) async {
    await Future.delayed(Duration(seconds: 1));

    final data = {'email': email, 'password': password};

    final response = await _client.post(URLs.auth, body: data);

    return ProfileModel.fromJson(response['data']);
  }

  @override
  Future<ProfileModel> authenticationSocial(
      {@required provider, @required data}) async {
    await Future.delayed(Duration(seconds: 1));

    final response = await _client.post(URLs.authSocial + provider, body: data);

    return ProfileModel.fromJson(response['data']);
  }

  @override
  Future<ProfileModel> signUpNormal({@required data}) async {
    await Future.delayed(Duration(seconds: 1));

    final response = await _client.post(URLs.register, body: data);

    return ProfileModel.fromJson(response['data']);
  }
}
