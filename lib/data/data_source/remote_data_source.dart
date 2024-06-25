import 'package:curso_avanzado_flutter/app/extensions.dart';
import 'package:curso_avanzado_flutter/data/network/apis/app_api.dart';
import 'package:curso_avanzado_flutter/data/request/request.dart';
import 'package:curso_avanzado_flutter/data/responses/login_response/login_response.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> loginCustomerRDS(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppApi appApi;

  const RemoteDataSourceImpl(
    this.appApi,
  );

  @override
  Future<LoginResponse> loginCustomerRDS(LoginRequest loginRequest) async {
    final response = await appApi.loginCustomer(loginRequest.toJson()).toMap();
    final LoginResponse loginResponse = LoginResponse.fromJson(response);
    return loginResponse;
  }
}
