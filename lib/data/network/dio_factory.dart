// ignore_for_file: constant_identifier_names
import 'package:curso_avanzado_flutter/app/app_preferences.dart';
import 'package:curso_avanzado_flutter/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APLICATION_JSON = 'application/json';
const String CONTENT_TYPE = 'content-Type';
const String ACCEPT = 'accept';
const String AUTHORIZATION = 'authorization';
const String DEFAULT_LANGUAGE = 'language';

class DioFactory {
  final AppPreferences appPreferences;

  const DioFactory(this.appPreferences);

  Future<Dio> getDio() async {
    final dio = Dio();

    const Duration timeOut = Duration(minutes: 1);

    Map<String, String> headers = {
      CONTENT_TYPE: APLICATION_JSON,
      ACCEPT: APLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: 'en',
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrlCustomers,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      headers: headers,
    );

    if (kReleaseMode) {
      print('Release mode no logs');
    } else {
      dio.interceptors.add(
        PrettyDioLogger(
          compact: true,
          error: true,
          requestHeader: true,
          request: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          logPrint: (object) => debugPrint(object.toString()),
        ),
      );
    }

    return dio;
  }
}
