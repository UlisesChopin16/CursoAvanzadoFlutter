import 'package:curso_avanzado_flutter/app/extensions.dart';
import 'package:curso_avanzado_flutter/data/responses/store_details_response/store_details_response.dart';
import 'package:curso_avanzado_flutter/domain/models/store_details_response_model/store_details_response_model.dart';

extension StoreDetailsMapper on StoreDetailsResponse {
  StoreDetailsResponseModel toDomain() {
    return StoreDetailsResponseModel(
      status: status.orZero(),
      message: message.orEmpty(),
      id: id.orZero(),
      about: about.orEmpty(),
      details: details.orEmpty(),
      image: image.orEmpty(),
      services: services.orEmpty(),
      title: title.orEmpty(),
    );
  }
}