import 'package:curso_avanzado_flutter/data/data_source/remote_data_source.dart';
import 'package:curso_avanzado_flutter/data/mapper/customer_mapper.dart';
import 'package:curso_avanzado_flutter/data/mapper/forgot_password_mapper.dart';
import 'package:curso_avanzado_flutter/data/network/error_handler.dart';
import 'package:curso_avanzado_flutter/data/network/failures/failure.dart';
import 'package:curso_avanzado_flutter/data/network/network_info/network_info.dart';
import 'package:curso_avanzado_flutter/data/request/forgot_password_request.dart';
import 'package:curso_avanzado_flutter/data/request/login_request.dart';
import 'package:curso_avanzado_flutter/data/request/register_request.dart';
import 'package:curso_avanzado_flutter/data/responses/forgot_password_response/forgot_password_response.dart';
import 'package:curso_avanzado_flutter/data/responses/login_response/login_response.dart';
import 'package:curso_avanzado_flutter/domain/models/forgot_password_model_rep/forgot_password_model_rep.dart';
import 'package:curso_avanzado_flutter/domain/models/login_response_model/login_response_model.dart';
import 'package:curso_avanzado_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const RepositoryImpl(
    this.remoteDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, LoginResponseModel>> loginCustomerRepository(
      LoginRequest loginRequest) async {
    LoginResponse response = const LoginResponse();
    try {
      final bool isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        // return connection error
        return const Left(
          Failure(
            code: 408,
            message: 'No internet connection, please try again later.',
          ),
        );
      }

      response = await remoteDataSource.loginCustomerRDS(loginRequest);

      if (response.status != 200) {
        // return error
        return Left(
          Failure(
            code: 409,
            message: response.message ?? 'Error in the request, please try again later.',
          ),
        );
      }
      return Right(response.toDomain());
    } catch (e) {
      return Left(
        ErrorHandler.handle(e).failure,
      );
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordModelRep>> forgotPasswordRepository(
      ForgotPasswordRequest forgotPasswordRequest) async {
    ForgotPasswordResponse response = const ForgotPasswordResponse();
    try {
      final bool isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        // return connection error
        return const Left(
          Failure(
            code: 408,
            message: 'No internet connection, please try again later.',
          ),
        );
      }

      response = await remoteDataSource.forgotPasswordRDS(forgotPasswordRequest);

      if (response.status != 200) {
        // return error
        return Left(
          Failure(
            code: 409,
            message: response.message ?? 'Error in the request, please try again later.',
          ),
        );
      }
      return Right(response.toDomain()); 
    } catch (e) {
      return Left(
        ErrorHandler.handle(e).failure,
      );
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> registerCustomerRepository(
      RegisterRequest registerRequest) async {
    LoginResponse response = const LoginResponse();
    try {
      final bool isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        // return connection error
        return const Left(
          Failure(
            code: 408,
            message: 'No internet connection, please try again later.',
          ),
        );
      }

      response = await remoteDataSource.registerCustomerRDS(registerRequest);

      if (response.status != 200) {
        // return error
        return Left(
          Failure(
            code: 409,
            message: response.message ?? 'Error in the request, please try again later.',
          ),
        );
      }
      return Right(response.toDomain());
    } catch (e) {
      return Left(
        ErrorHandler.handle(e).failure,
      );
    }
  }
}
