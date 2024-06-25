import 'package:curso_avanzado_flutter/data/network/failures/failure.dart';
import 'package:curso_avanzado_flutter/data/request/request.dart';
import 'package:curso_avanzado_flutter/domain/models/login_response_model/login_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, LoginResponseModel>> loginCustomerRepository(LoginRequest loginResponse);
}
