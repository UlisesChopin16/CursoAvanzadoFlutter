
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_response.freezed.dart';
part 'home_response.g.dart';

@freezed
class HomeResponse with _$HomeResponse {
  const factory HomeResponse({
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'data') Data? data,
  }) = _HomeResponse;

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    @JsonKey(name: 'services') List<Content>? services,
    @JsonKey(name: 'banners') List<Content>? banners,
    @JsonKey(name: 'stores') List<Content>? stores,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class Content with _$Content {
  const factory Content({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'image') String? image,
  }) = _Content;

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
}