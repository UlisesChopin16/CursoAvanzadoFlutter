import 'package:curso_avanzado_flutter/data/network/apis/app_api.dart';
import 'package:curso_avanzado_flutter/data/request/request.dart';
import 'package:curso_avanzado_flutter/data/responses/login_response/login_response.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> loginCustomer(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppApi appApi;

  const RemoteDataSourceImpl(
    this.appApi,
  );

  @override
  Future<LoginResponse> loginCustomer(LoginRequest loginRequest) async {
    return await appApi.loginCustomer(loginRequest.toJson());
  }
}
