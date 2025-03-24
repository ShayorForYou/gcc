import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gcc_portal/app_config.dart';
import 'package:gcc_portal/utils/widgets/my_widgets.dart';
import 'package:toastification/toastification.dart';

import '../../main.dart';
import '../../screens/auth/login.dart';
import 'init_prefs.dart';

Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

Dio dio = Dio(BaseOptions(
  receiveTimeout: const Duration(seconds: 30),
  connectTimeout: const Duration(seconds: 30),
  baseUrl: AppConfig.apiUrl,
));
const storage = FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
    aOptions: AndroidOptions(
      resetOnError: true,
      encryptedSharedPreferences: true,
    ));

class DioService {
  static Future<Response> postRequest(
      {required String url,
      required dynamic body,
      bool addInterceptors = true,
      Map<String, String>? customHeaders}) async {
    dio.interceptors.clear();

    if (addInterceptors) {
      dio.interceptors.add(
        customInterceptor(),
      );
    }
    return dio.post(url,
        options: Options(
          headers: customHeaders ?? headers,
        ),
        data: body);
  }

  static Future<Response> getRequest(
      {required String url, Map<String, String>? customHeaders}) async {
    dio.interceptors.clear();

    dio.interceptors.add(
      customInterceptor(),
    );
    return dio.get(url,
        options: Options(
          headers: customHeaders ?? headers,
        ));
  }
}

Interceptor customInterceptor() {
  return InterceptorsWrapper(onRequest: (options, handler) async {
    String accessToken = await storage.read(key: 'token') ?? '';

    options.headers
        .addAll({...headers, 'Authorization': 'Bearer $accessToken'});
    debugPrint(
        'REQUEST[${options.method}] => PATH: ${options.path} $accessToken \n'
        'REQUEST BODY[${options.method}] => PATH: ${options.data}');
    return handler.next(options);
  }, onResponse: (response, handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.data}');
    return handler.next(response);
  }, onError: (DioException e, handler) async {
    debugPrint(
        'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.baseUrl + e.requestOptions.path}');

    if (e.response?.statusCode == 401 &&
        e.response?.data['message'] == 'Session Expired.') {
      // final newToken = await refreshToken();
      // if (newToken != null) {
      //   dio.options.headers['Authorization'] = 'Bearer $newToken';
      //   return handler.resolve(await dio.fetch(e.requestOptions));
      // }
      await SharedPrefs.clearValues();
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()),
      );
      MyWidgets().showToast(
        type: ToastificationType.info,
        message: 'দয়া করে পুনরায় লগইন করুন',
        icon: Icons.info,
      );
      return handler.next(e);
    } else if (e.response?.statusCode == 422) {
      StringBuffer errorMessages = StringBuffer();
      e.response?.data['errors'].forEach((key, value) {
        for (var error in value) {
          errorMessages.writeln('- $error');
        }
        return handler.next(e);
      });
      MyWidgets().showToast(
        type: ToastificationType.info,
        message: errorMessages.toString(),
        icon: Icons.info,
      );
      return handler.next(e);
    } else if (e.response?.statusCode == 400) {
      print(e.response?.data);
      MyWidgets().showToast(
        type: ToastificationType.info,
        message: e.response?.data['error'],
        icon: Icons.info,
      );
      return handler.next(e);
    }
    return handler.next(e);
  });
}

Future<String?> refreshToken() async {
  try {
    String token = await storage.read(key: 'token') ?? '';
    final response = await dio.post(
      '/refresh',
      options: Options(headers: {
        ...headers,
        'Authorization': 'Bearer $token',
      }),
    );
    final newToken = response.data['access_token'];
    storage.write(key: 'token', value: newToken);
    return newToken;
  } catch (e) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => const Login()),
    );
    MyWidgets().showToast(
      type: ToastificationType.info,
      message: 'দয়া করে পুনরায় লগইন করুন',
      icon: Icons.info,
    );
    debugPrint('Error while refreshing token: $e');
  }
  return null;
}
