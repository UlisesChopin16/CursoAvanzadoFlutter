import 'package:curso_avanzado_flutter/domain/models/home_response_model/home_content_response_model.dart';

class HomeDataResponseModel {
  final List<HomeContentResponseModel> services;
  final List<HomeContentResponseModel> banners;
  final List<HomeContentResponseModel> stores;

  HomeDataResponseModel({
    required this.services,
    required this.banners,
    required this.stores,
  });
}