import 'package:curso_avanzado_flutter/data/network/failures/failure.dart';
import 'package:curso_avanzado_flutter/data/request/register_request.dart';
import 'package:curso_avanzado_flutter/domain/models/login_response_model/login_response_model.dart';
import 'package:curso_avanzado_flutter/data/repository/repository.dart';
import 'package:curso_avanzado_flutter/domain/usecase/base_use_case.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput, LoginResponseModel> {
  final Repository repository;

  const RegisterUseCase(this.repository);
  // this is the function that will be called from the UI
  @override
  Future<Either<Failure, LoginResponseModel>> execute(RegisterUseCaseInput input) async {
    // first we get the device info

    // then we call the repository to login the customer
    final response = await repository.registerCustomerRepository(
      RegisterRequest(
        email: input.email,
        countryMobileCode: input.countryMobileCode,
        userName: input.userName,
        password: input.password,
        mobileNumber: input.mobileNumber,
        profilePicture: input.profilePicture,
      ),
    );

    return response;
  }
}

class RegisterUseCaseInput {
  final String countryMobileCode;
  final String userName;
  final String email;
  final String password;
  final String mobileNumber;
  final String profilePicture;

  const RegisterUseCaseInput({
    required this.email,
    required this.countryMobileCode,
    required this.userName,
    required this.password,
    required this.mobileNumber,
    required this.profilePicture,
  });
}
