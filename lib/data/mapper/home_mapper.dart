import 'package:curso_avanzado_flutter/app/extensions.dart';
import 'package:curso_avanzado_flutter/data/responses/home_response/home_response.dart';
import 'package:curso_avanzado_flutter/domain/models/home_response_model/home_content_response_model.dart';
import 'package:curso_avanzado_flutter/domain/models/home_response_model/home_data_response_model.dart';
import 'package:curso_avanzado_flutter/domain/models/home_response_model/home_response_model.dart';

extension HomeMapper on HomeResponse {
  HomeResponseModel toDomain() {
    return HomeResponseModel(
      message: message.orEmpty(),
      status: status.orZero(),
      data: data.toDomain(),
    );
  }
}

extension HomeDataMapper on Data? {
  HomeDataResponseModel toDomain() {
    return HomeDataResponseModel(
      services: this?.services?.map((e) => e.toDomain()).toList() ?? [],
      banners: this?.banners?.map((e) => e.toDomain()).toList() ?? [],
      stores: this?.stores?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension ContentMapper on Content {
  HomeContentResponseModel toDomain() {
    return HomeContentResponseModel(
      id: id.orZero(),
      title: title.orEmpty(),
      image: image.orEmpty(),
    );
  }
}