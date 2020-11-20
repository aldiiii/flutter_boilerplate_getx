import 'package:starter_kit_app/constants/urls.dart';
import 'package:starter_kit_app/controllers/auth_controller.dart';
import 'package:starter_kit_app/utils/exceptions/server_exception.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

abstract class HttpClient {
  Future<dynamic> get(String url,
      {Map<String, dynamic> headers,
      Map<String, dynamic> queryParameters,
      bool authorization = false});
  Future<dynamic> post(String url,
      {Map headers, @required body, bool authorization = false});
  Future<dynamic> put(String url,
      {Map headers, @required body, bool authorization = false});
}

class HttpClientImpl implements HttpClient {
  final Dio _dio;

  HttpClientImpl(this._dio) {
    _initApiClient();
  }

  void _initApiClient() {
    _dio..options.baseUrl = URLs.baseUrl;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          return options;
        },
        onResponse: (Response response) async {
          print(
              "<-- ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
          print("Response: ${response.data}");
          print("<-- END HTTP");
          return response;
        },
        onError: (DioError e) async {
          // if (e.response.data['message'] == 'Invalid JWT Token') {
          //   Modular.to.pushReplacementNamed(Routers.userLogin);
          // }

          return e;
        },
      ),
    );
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    bool authorization = false,
  }) async {
    try {
      if (authorization) {
        _dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (RequestOptions options) async {
              if (!options.headers.containsKey("Authorization") &&
                  AuthController.to.token != null) {
                options.headers["Authorization"] =
                    "Bearer ${AuthController.to.token}";
              }
              return options;
            },
            onResponse: (Response response) async {
              return response;
            },
            onError: (DioError e) async {
              // if (e.response.data['message'] == 'Invalid JWT Token') {
              //   Modular.to.pushReplacementNamed(Routers.userLogin);
              // }

              return e;
            },
          ),
        );
      }

      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      // final String res = json.encode(response.data);
      // print('[API Dio Helper - GET] Server Response: $res');

      return response.data;
    } on DioError catch (e) {
      // print('[API Dio Helper - GET] Connection Exception => ' + e.message);

      if (e?.response?.data != null) throw Exception(e.response.data);

      throw Exception(e.message);
    }
  }

  @override
  Future<dynamic> post(
    String url, {
    Map headers,
    @required body,
    bool authorization = false,
  }) async {
    try {
      // print('[API Dio Helper - POST] Server Request: $body');

      if (authorization) {
        _dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (RequestOptions options) async {
              if (!options.headers.containsKey("Authorization") &&
                  AuthController.to.token != null) {
                options.headers["Authorization"] =
                    "Bearer ${AuthController.to.token}";
              }
              return options;
            },
            onResponse: (Response response) async {
              return response;
            },
            onError: (DioError e) async {
              // if (e.response.data['message'] == 'Invalid JWT Token') {
              //   Modular.to.pushReplacementNamed(Routers.userLogin);
              // }

              return e;
            },
          ),
        );
      }

      final response =
          await _dio.post(url, data: body, options: Options(headers: headers));

      // final String res = json.encode(response.data);
      // print('[API Dio Helper - POST] Server Response: ' + res);

      return response.data;
    } on DioError catch (e) {
      // print('[API Dio Helper - POST] Connection Exception => ' + e.message);

      // if (e.response.statusCode == 401) {
      //   Modular.to.pushReplacementNamed(Routers.userLogin);
      // }

      if (e?.response?.data != null)
        throw ServerException(e.response.data['error']);

      throw Exception(e.message);
    }
  }

  @override
  Future put(
    String url, {
    Map headers,
    @required body,
    bool authorization = false,
  }) async {
    try {
      // print('[API Dio Helper - POST] Server Request: $body');
      if (authorization) {
        _dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (RequestOptions options) async {
              print('TOKENN >>> ${AuthController.to.token}');

              if (!options.headers.containsKey("Authorization") &&
                  AuthController.to.token != null) {
                options.headers["Authorization"] =
                    "Bearer ${AuthController.to.token}";
              }
              return options;
            },
            onResponse: (Response response) async {
              return response;
            },
            onError: (DioError e) async {
              // if (e.response.data['message'] == 'Invalid JWT Token') {
              //   Modular.to.pushReplacementNamed(Routers.userLogin);
              // }

              return e;
            },
          ),
        );
      }

      final response =
          await _dio.put(url, data: body, options: Options(headers: headers));

      // final String res = json.encode(response.data);
      // print('[API Dio Helper - POST] Server Response: ' + res);

      return response.data;
    } on DioError catch (e) {
      // print('[API Dio Helper - POST] Connection Exception => ' + e.message);

      if (e?.response?.data != null) throw ServerException(e.response.data);

      throw Exception(e.message);
    }
  }
}
