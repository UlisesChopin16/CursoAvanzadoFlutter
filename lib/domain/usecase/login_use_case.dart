import 'package:curso_avanzado_flutter/app/functions.dart';
import 'package:curso_avanzado_flutter/data/network/failures/failure.dart';
import 'package:curso_avanzado_flutter/data/request/request.dart';
import 'package:curso_avanzado_flutter/domain/models/device_info/device_info.dart';
import 'package:curso_avanzado_flutter/domain/models/login_response_model/login_response_model.dart';
import 'package:curso_avanzado_flutter/domain/repository/repository.dart';
import 'package:curso_avanzado_flutter/domain/usecase/base_use_case.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, LoginResponseModel> {
  final Repository repository;

  const LoginUseCase(this.repository);
  // this is the function that will be called from the UI
  @override
  Future<Either<Failure, LoginResponseModel>> execute(LoginUseCaseInput input) async {
    // first we get the device info
    DeviceInfo deviceInfo = await getDeviceInfo();

    // then we call the repository to login the customer
    final response = await repository.loginCustomerRepository(
      LoginRequest(
        email: input.email,
        password: input.password,
        imei: deviceInfo.identifier,
        deviceName: deviceInfo.name,
      ),
    );

    return response;
  }
}

class LoginUseCaseInput {
  final String email;
  final String password;

  const LoginUseCaseInput({
    required this.email,
    required this.password,
  });
}
