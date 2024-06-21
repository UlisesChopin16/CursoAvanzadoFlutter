
// to convert the response into a non nullable object (model)

import 'package:curso_avanzado_flutter/app/extensions.dart';
import 'package:curso_avanzado_flutter/data/responses/login_response/login_response.dart';
import 'package:curso_avanzado_flutter/domain/models/contact_model/contact_model.dart';
import 'package:curso_avanzado_flutter/domain/models/customer_model/customer_model.dart';
import 'package:curso_avanzado_flutter/domain/models/login_response_model/login_response_model.dart';

const empty = '';
const zero = 0;

extension CustomerResponseMapper on CustomerResponse? {
  CustomerModel toDomain() {
    return CustomerModel(
      // if this is null, return an empty string
      id: this?.id.orEmpty() ?? empty,
      name: this?.name.orEmpty() ?? empty,
      apellidoP: this?.apellidoP.orEmpty() ?? empty,
      apellidoM: this?.apellidoM.orEmpty() ?? empty,
      numOfNotifications: this?.numOfNotifications.orZero() ?? zero,
    );
  }
}

// contact response mapper
extension ContactResponseMapper on ContactResponse? {
  ContactModel toDomain() {
    return ContactModel(
      phone: this?.phone.orEmpty() ?? empty,
      webSite: this?.webSite.orEmpty() ?? empty,
      email: this?.email.orEmpty() ?? empty,
      github: this?.github.orEmpty() ?? empty,
    );
  }
}

// login response mapper

extension LoginResponseMapper on LoginResponse {
  LoginResponseModel toDomain() {
    return LoginResponseModel(
      status: status.orZero(),
      message: message.orEmpty(),
      customer: customer.toDomain(),
      contacts: contacts.toDomain(),
    );
  }
}
