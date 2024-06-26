import 'package:curso_avanzado_flutter/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'customer_app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrlCustomers)
abstract class CustomerAppApi {
  static const String login = "/login";
  static const String forgotpassword = "/forgotpassword";

  factory CustomerAppApi(Dio dio, {String baseUrl}) = _CustomerAppApi;

  @POST(login)
  Future<String> loginCustomer(
    @Body() Map<String, dynamic> body,
  );

  @POST(forgotpassword)
  Future<String> forgotPassword(
    @Body() Map<String, dynamic> body,
  );
}
