import 'package:curso_avanzado_flutter/data/responses/forgot_password_response/forgot_password_response.dart';
import 'package:curso_avanzado_flutter/data/responses/home_response/home_response.dart';
import 'package:curso_avanzado_flutter/data/responses/login_response/login_response.dart';
import 'package:curso_avanzado_flutter/data/responses/store_details_response/store_details_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'customer_app_api.g.dart';

@RestApi()
abstract class CustomerAppApi {
  static const String login = "/login";
  static const String forgotpassword = "/forgotpassword";
  static const String register = "/register";
  static const String home = "/home";
  static const String storeDetails = "/store-details/1";

  factory CustomerAppApi(Dio dio) = _CustomerAppApi;

  @POST(login)
  Future<LoginResponse> loginCustomer(
    @Body() Map<String, dynamic> body,
  );

  @POST(forgotpassword)
  Future<ForgotPasswordResponse> forgotPassword(
    @Body() Map<String, dynamic> body,
  );

  @POST(register)
  Future<LoginResponse> registerCustomer(
    @Body() Map<String, dynamic> body,
  );

  @GET(home)
  Future<HomeResponse> getHome();

  @GET(storeDetails)
  Future<StoreDetailsResponse> getStoreDetails();
}
