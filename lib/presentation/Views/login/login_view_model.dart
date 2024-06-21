import 'dart:async';

import 'package:curso_avanzado_flutter/presentation/base/base_view_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_view_model.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  const factory LoginObject({
    required String userName,
    required String password,
  }) = _LoginObject;

  factory LoginObject.fromJson(Map<String, dynamic> json) => _$LoginObjectFromJson(json);
}

class LoginViewModel extends BaseViewModels implements LoginViewModelInputs, LoginViewModelOutputs {
  StreamController<String> userNameController = StreamController<String>.broadcast();
  StreamController<String> passwordController = StreamController<String>.broadcast();

  var loginObject = const LoginObject(
    userName: '',
    password: '',
  );

  // inputs
  @override
  void dispose() {
    userNameController.close();
    passwordController.close();
  }

  @override
  void start() {}

  @override
  void login() {
    // TODO: implement login
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password);
  }

  @override
  void setUserName(String userName) {
    inputUserName.add(userName);
  }

  @override
  Sink<String> get inputUserName => userNameController.sink;

  @override
  Sink<String> get inputPassword => passwordController.sink;

  // outputs
  @override
  Stream<bool> get outputIsPasswordValid =>
      passwordController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid =>
      userNameController.stream.map((user) => _isUserNameValid(user));

  // private methods
  bool _isPasswordValid(String password) {
    if (password.length < 6) {
      return false;
    }
    if (password.trim().isEmpty) {
      return false;
    }
    if (password.contains(' ')) {
      return false;
    }
    return true;
  }

  bool _isUserNameValid(String userName) {
    if (userName.trim().isEmpty) {
      return false;
    }
    if (userName.contains(' ')) {
      return false;
    }
    return true;
  }
}

abstract class LoginViewModelInputs {
  // three functions
  void setUserName(String userName);
  void setPassword(String password);
  void login();

  // two sinks
  Sink<String> get inputUserName;
  Sink<String> get inputPassword;
}

abstract class LoginViewModelOutputs {
  // two streams
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
}
