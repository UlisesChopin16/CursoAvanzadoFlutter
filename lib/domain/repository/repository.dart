import 'package:curso_avanzado_flutter/data/network/failures/failure.dart';
import 'package:curso_avanzado_flutter/data/request/forgot_password_request.dart';
import 'package:curso_avanzado_flutter/data/request/login_request.dart';
import 'package:curso_avanzado_flutter/domain/models/forgot_password_model_rep/forgot_password_model_rep.dart';
import 'package:curso_avanzado_flutter/domain/models/login_response_model/login_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, LoginResponseModel>> loginCustomerRepository(LoginRequest loginResponse);
  Future<Either<Failure, ForgotPasswordModelRep>> forgotPasswordRepository(
    ForgotPasswordRequest loginResponse,
  );
}
