import 'package:curso_avanzado_flutter/constants/constants.dart';
import 'package:curso_avanzado_flutter/data/responses/forgot_password_response/forgot_password_response.dart';
import 'package:curso_avanzado_flutter/data/responses/login_response/login_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'customer_app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrlCustomers)
abstract class CustomerAppApi {
  static const String login = "/login";
  static const String forgotpassword = "/forgotpassword";

  factory CustomerAppApi(Dio dio, {String baseUrl}) = _CustomerAppApi;

  @POST(login)
  Future<LoginResponse> loginCustomer(
    @Body() Map<String, dynamic> body,
  );

  @POST(forgotpassword)
  Future<ForgotPasswordResponse> forgotPassword(
    @Body() Map<String, dynamic> body,
  );
}
