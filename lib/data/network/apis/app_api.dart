import 'package:curso_avanzado_flutter/constants/constants.dart';
import 'package:curso_avanzado_flutter/data/responses/login_response/login_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrlCustomers)
abstract class AppApi {
  static const String login = "/login";

  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  @POST(login)
  Future<String> loginCustomer(
    @Body() Map<String, dynamic> body,
  );
}
