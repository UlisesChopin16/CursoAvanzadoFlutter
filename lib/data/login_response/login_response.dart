import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'customer')
  final Customer? customer;
  @JsonKey(name: 'contacts')
  final Contacts? contacts;

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
class Customer {
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

  const Customer({
    this.id,
    this.name,
    this.apellidoP,
    this.apellidoM,
    this.numOfNotifications,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

@JsonSerializable()
class Contacts {
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'web_site')
  final String? webSite;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'github')
  final String? github;

  const Contacts({
    this.phone,
    this.webSite,
    this.email,
    this.github,
  });

  factory Contacts.fromJson(Map<String, dynamic> json) =>
      _$ContactsFromJson(json);  

  Map<String, dynamic> toJson() => _$ContactsToJson(this);
}
