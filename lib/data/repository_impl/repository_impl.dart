import 'package:curso_avanzado_flutter/data/data_source/remote_data_source.dart';
import 'package:curso_avanzado_flutter/data/mapper/mapper.dart';
import 'package:curso_avanzado_flutter/data/network/error_handler.dart';
import 'package:curso_avanzado_flutter/data/network/failures/failure.dart';
import 'package:curso_avanzado_flutter/data/network/network_info/network_info.dart';
import 'package:curso_avanzado_flutter/data/request/request.dart';
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
  Future<Either<Failure, LoginResponseModel>> loginCustomer(LoginRequest loginResponse) async {
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
      final response = await remoteDataSource.loginCustomer(loginResponse);
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
