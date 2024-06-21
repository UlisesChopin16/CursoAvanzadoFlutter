import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'customer')
  final CustomerResponse? customer;
  @JsonKey(name: 'contacts')
  final ContactResponse? contacts;

  const LoginResponse({
    this.status,
    this.message,
    this.customer,
    this.contacts,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'apellido_p')
  final String? apellidoP;
  @JsonKey(name: 'apellido_m')
  final String? apellidoM;
  @JsonKey(name: 'numOfNotifications')
  final int? numOfNotifications;

  const CustomerResponse({
    this.id,
    this.name,
    this.apellidoP,
    this.apellidoM,
    this.numOfNotifications,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactResponse {
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'web_site')
  final String? webSite;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'github')
  final String? github;

  const ContactResponse({
    this.phone,
    this.webSite,
    this.email,
    this.github,
  });

  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactResponseFromJson(json);  

  Map<String, dynamic> toJson() => _$ContactResponseToJson(this);
}
