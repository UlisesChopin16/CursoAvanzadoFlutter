import 'package:curso_avanzado_flutter/data/network/failures/failure.dart';
import 'package:curso_avanzado_flutter/domain/models/home_response_model/home_response_model.dart';
import 'package:curso_avanzado_flutter/domain/repository/repository.dart';
import 'package:curso_avanzado_flutter/domain/usecase/base_use_case.dart';
import 'package:dartz/dartz.dart';

class HomeUseCase implements BaseUseCase<void, HomeResponseModel> {
  final Repository repository;

  const HomeUseCase(this.repository);
  // this is the function that will be called from the UI
  @override
  Future<Either<Failure, HomeResponseModel>> execute(void data) async {
    // first we get the device info

    // then we call the repository to login the customer
    final response = await repository.getHomeRepository();

    return response;
  }
}
