import 'package:curso_avanzado_flutter/data/network/failures/failure.dart';
import 'package:curso_avanzado_flutter/data/repository/repository.dart';
import 'package:curso_avanzado_flutter/domain/models/store_details_response_model/store_details_response_model.dart';
import 'package:curso_avanzado_flutter/domain/usecase/base_use_case.dart';
import 'package:dartz/dartz.dart';

class StoreDetailsUseCase implements BaseUseCase<void, StoreDetailsResponseModel> {
  final Repository repository;

  const StoreDetailsUseCase(this.repository);
  // this is the function that will be called from the UI
  @override
  Future<Either<Failure, StoreDetailsResponseModel>> execute(void data) async {
    // first we get the device info

    // then we call the repository to login the customer
    final response = await repository.getStoreDetailsRepository();

    return response;
  }
}
