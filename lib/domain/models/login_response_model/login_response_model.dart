import 'package:curso_avanzado_flutter/domain/models/contact_model/contact_model.dart';
import 'package:curso_avanzado_flutter/domain/models/customer_model/customer_model.dart';

class LoginResponseModel {
  final int status;
  final String message;
  final CustomerModel customer;
  final ContactModel contacts;

  const LoginResponseModel({
    required this.status,
    required this.message,
    required this.customer,
    required this.contacts,
  });
}