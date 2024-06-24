import 'dart:async';

import 'package:curso_avanzado_flutter/domain/usecase/login_use_case.dart';
import 'package:curso_avanzado_flutter/presentation/base/base_view_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_view_model.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  const factory LoginObject({
    required String userName,
    required String password,
  }) = _LoginObject;
}

class LoginViewModel extends BaseViewModels implements LoginViewModelInputs, LoginViewModelOutputs {
  StreamController<String> userNameController = StreamController<String>.broadcast();
  StreamController<String> passwordController = StreamController<String>.broadcast();

  StreamController<void> isAllInputsValidController = StreamController<void>.broadcast();

  var loginObject = const LoginObject(
    userName: '',
    password: '',
  );

  LoginUseCase? loginUseCase;

  LoginViewModel({this.loginUseCase});

  // inputs
  @override
  void dispose() {
    userNameController.close();
    passwordController.close();
    isAllInputsValidController.close();
  }

  @override
  void start() {}

  @override
  void login() async {
    (await loginUseCase!.execute(
      LoginUseCaseInput(
        email: loginObject.userName,
        password: loginObject.password,
      ),
    ))
        .fold((failure) {
      print(failure.message);
    }, (data) {
      print(data.customer.name);
    });
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password); // data class operation same as kotlin
    _validate();
  }

  @override
  void setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName); // data class operation same as kotlin
    _validate();
  }

  @override
  Sink<String> get inputUserName => userNameController.sink;

  @override
  Sink<String> get inputPassword => passwordController.sink;
  
  @override
  Sink<void> get inputIsAllInputsValid => isAllInputsValidController.sink;


  // outputs
  @override
  Stream<bool> get outputIsPasswordValid =>
      passwordController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid =>
      userNameController.stream.map((user) => _isUserNameValid(user));

  @override
  Stream<bool> get outputIsAllInputsValid => isAllInputsValidController.stream.map((_) => _isAllInputsValid());


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

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) && _isUserNameValid(loginObject.userName);
  }

  void _validate () {
    inputIsAllInputsValid.add(null);
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
  Sink<void> get inputIsAllInputsValid;
}

abstract class LoginViewModelOutputs {
  // two streams
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
