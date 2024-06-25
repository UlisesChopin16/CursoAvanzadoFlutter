import 'package:curso_avanzado_flutter/app/app_preferences.dart';
import 'package:curso_avanzado_flutter/app/di.dart';
import 'package:curso_avanzado_flutter/domain/usecase/login_use_case.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_renderer.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_view_model.freezed.dart';
part 'login_view_model.g.dart';

@freezed
class LoginObject with _$LoginObject {
  const factory LoginObject({
    @Default('') String userName,
    @Default('') String password,
    @Default(true) bool isUserNameValid,
    @Default(true) bool isPasswordValid,
    @Default(false) bool isAllInputsValid,
    @Default(false) bool isUserLoggedIn,
    @Default(null) FlowState? flowState,
  }) = _LoginObject;
}

@riverpod
class LoginViewModel extends _$LoginViewModel implements LoginViewModelInputs {
  final LoginUseCase _loginUseCase = instance<LoginUseCase>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  LoginObject build() {
    return const LoginObject();
  }

  @override
  void login({required VoidCallback onDone}) async {
    state = state.copyWith(
      flowState: LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
      ),
    );
    final response = await _loginUseCase.execute(
      LoginUseCaseInput(
        email: state.userName,
        password: state.password,
      ),
    );

    response.fold(
      (failure) {
        state = state.copyWith(
          flowState: ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.message,
          ),
        );
      },
      (loginResponseModel) {
        state = state.copyWith(
          flowState: ContentState(),
          isUserLoggedIn: true,
        );
        _appPreferences.setIsUserLoggedIn()
        
        ;
        onDone();
      },
    );
  }

  @override
  void setPassword(String password) {
    state = state.copyWith(
      password: password,
      isPasswordValid: _isPasswordValid(password),
    ); // data class operation same as kotlin
    _validate();
  }

  @override
  void setUserName(String userName) {
    state = state.copyWith(
      userName: userName,
      isUserNameValid: _isUserNameValid(userName),
    );
    _validate();
  }

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
    return _isPasswordValid(state.password) && _isUserNameValid(state.userName);
  }

  void _validate() {
    state = state.copyWith(
      isAllInputsValid: _isAllInputsValid(),
    );
  }

  void retryAction() {
    state = state.copyWith(
      flowState: ContentState(),
    );
  }
}

abstract class LoginViewModelInputs {
  // three functions
  void setUserName(String userName);
  void setPassword(String password);
  void login({required VoidCallback onDone});
}
