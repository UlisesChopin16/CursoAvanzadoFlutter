import 'package:curso_avanzado_flutter/data/network/failures/failure.dart';
import 'package:curso_avanzado_flutter/data/request/forgot_password_request.dart';
import 'package:curso_avanzado_flutter/domain/models/forgot_password_model_rep/forgot_password_model_rep.dart';
import 'package:curso_avanzado_flutter/domain/repository/repository.dart';
import 'package:curso_avanzado_flutter/domain/usecase/base_use_case.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordUseCase implements BaseUseCase<ForgotPasswordUseCaseInput, ForgotPasswordModelRep>{

  final Repository repository;

  const ForgotPasswordUseCase(this.repository);
  // this is the function that will be called from the UI
  @override
  Future<Either<Failure, ForgotPasswordModelRep>> execute(ForgotPasswordUseCaseInput input) async {
    // first we get the device info

    // then we call the repository to login the customer
    final response = await repository.forgotPasswordRepository(
      ForgotPasswordRequest(
        email: input.email,
      ),
    );

    return response;
  }
}

class ForgotPasswordUseCaseInput {
  final String email;

  const ForgotPasswordUseCaseInput({
    required this.email,
  });
}