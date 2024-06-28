import 'package:curso_avanzado_flutter/domain/models/home_response_model/home_data_response_model.dart';

class HomeResponseModel {
  final String message;
  final int status;
  final HomeDataResponseModel data;

  HomeResponseModel({
    required this.message,
    required this.status,
    required this.data,
  });
}
