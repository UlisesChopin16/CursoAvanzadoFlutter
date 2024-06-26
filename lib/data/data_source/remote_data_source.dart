import 'package:curso_avanzado_flutter/app/extensions.dart';
import 'package:curso_avanzado_flutter/data/network/apis/customer_apis/customer_app_api.dart';
import 'package:curso_avanzado_flutter/data/request/forgot_password_request.dart';
import 'package:curso_avanzado_flutter/data/request/login_request.dart';
import 'package:curso_avanzado_flutter/data/responses/forgot_password_response/forgot_password_response.dart';
import 'package:curso_avanzado_flutter/data/responses/login_response/login_response.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> loginCustomerRDS(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPasswordRDS(ForgotPasswordRequest forgotPasswordRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final CustomerAppApi customerAppApi;

  const RemoteDataSourceImpl(
    this.customerAppApi,
  );

  @override
  Future<LoginResponse> loginCustomerRDS(LoginRequest loginRequest) async {
    final response = await customerAppApi.loginCustomer(loginRequest.toJson()).toMap();
    final LoginResponse loginResponse = LoginResponse.fromJson(response);
    return loginResponse;
  }

  @override
  Future<ForgotPasswordResponse> forgotPasswordRDS(ForgotPasswordRequest forgotPasswordRequest) async {
    final response = await customerAppApi.forgotPassword(forgotPasswordRequest.toJson()).toMap();
    final ForgotPasswordResponse forgotPasswordResponse = ForgotPasswordResponse.fromJson(response);
    return forgotPasswordResponse;
  }
}
