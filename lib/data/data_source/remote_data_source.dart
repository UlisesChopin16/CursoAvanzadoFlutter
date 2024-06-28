import 'package:curso_avanzado_flutter/data/network/apis/customer_apis/customer_app_api.dart';
import 'package:curso_avanzado_flutter/data/request/forgot_password_request.dart';
import 'package:curso_avanzado_flutter/data/request/login_request.dart';
import 'package:curso_avanzado_flutter/data/request/register_request.dart';
import 'package:curso_avanzado_flutter/data/responses/forgot_password_response/forgot_password_response.dart';
import 'package:curso_avanzado_flutter/data/responses/home_response/home_response.dart';
import 'package:curso_avanzado_flutter/data/responses/login_response/login_response.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> loginCustomerRDS(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPasswordRDS(ForgotPasswordRequest forgotPasswordRequest);
  Future<LoginResponse> registerCustomerRDS(RegisterRequest registerRequest);
  Future<HomeResponse> getHomeRDS();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final CustomerAppApi customerAppApi;

  const RemoteDataSourceImpl(
    this.customerAppApi,
  );

  @override
  Future<LoginResponse> loginCustomerRDS(LoginRequest loginRequest) async {
    final response = await customerAppApi.loginCustomer(loginRequest.toJson());
    return response;
  }

  @override
  Future<ForgotPasswordResponse> forgotPasswordRDS(
      ForgotPasswordRequest forgotPasswordRequest) async {
    final response = await customerAppApi.forgotPassword(forgotPasswordRequest.toJson());
    return response;
  }
  
  @override
  Future<LoginResponse> registerCustomerRDS(RegisterRequest registerRequest) async {
    final response = await customerAppApi.registerCustomer(registerRequest.toJson());
    return response;
  }

  @override
  Future<HomeResponse> getHomeRDS() async {
    final response = await customerAppApi.getHome();
    return response;
  }
}
