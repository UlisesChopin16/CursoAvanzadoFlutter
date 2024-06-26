import 'package:curso_avanzado_flutter/app/extensions.dart';
import 'package:curso_avanzado_flutter/data/responses/forgot_password_response/forgot_password_response.dart';
import 'package:curso_avanzado_flutter/domain/models/forgot_password_model_rep/forgot_password_model_rep.dart';

extension ForgotPasswordMapper on ForgotPasswordResponse {
  ForgotPasswordModelRep toDomain() {
    return ForgotPasswordModelRep(
      status: status.orZero(),
      message: message.orEmpty(),
      password: password.orEmpty(),
    );
  }
}