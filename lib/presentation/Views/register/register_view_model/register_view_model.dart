import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_renderer.dart';
import 'package:curso_avanzado_flutter/presentation/validations/validations.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_view_model.freezed.dart';
part 'register_view_model.g.dart';

@freezed
class RegisterModel with _$RegisterModel {
  const factory RegisterModel({
    @Default('') String countryMobileCode,
    @Default('') String userName,
    @Default('') String email,
    @Default('') String password,
    @Default('') String mobileNumber,
    @Default(true) bool isUserNameValid,
    @Default(true) bool isEmailValid,
    @Default(true) bool isPasswordValid,
    @Default(true) bool isMobileNumberValid,
    @Default(false) bool isAllInputsValid,
    @Default(null) FlowState? flowState,
  }) = _RegisterModel;
}

@riverpod
class RegisterViewModel extends _$RegisterViewModel implements RegisterViewModelInputs {
  @override
  RegisterModel build() {
    return const RegisterModel();
  }

  @override
  void onCountryMobileCodeChanged(String countryMobileCode) {
    state = state.copyWith(
      countryMobileCode: countryMobileCode.trim(),
    );
    _validate();
  }

  @override
  void onUserNameChanged(String userName) {
    state = state.copyWith(
      userName: userName.trim(),
    );
    _validate();
  }

  @override
  void onEmailChanged(String email) {
    state = state.copyWith(
      email: email.trim(),
    );
    _validate();
  }

  @override
  void onPasswordChanged(String password) {
    state = state.copyWith(
      password: password.trim(),
    );
    _validate();
  }

  @override
  void onMobileNumberChanged(String mobileNumber) {
    state = state.copyWith(
      mobileNumber: mobileNumber.trim(),
    );
    _validate();
  }

  @override
  void onRegister({required VoidCallback onDone}) {
    state = state.copyWith(
      flowState: LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
      ),
    );
    // call the register use case
    onDone();
  }

  bool validateAllInputs() {
    return state.isUserNameValid &&
        state.isEmailValid &&
        state.isPasswordValid &&
        state.isMobileNumberValid;
  }

  void _validate() {
    state = state.copyWith(
      isUserNameValid: Validations.isUserNameValid(state.userName),
      isEmailValid: Validations.isEmailValid(state.email),
      isPasswordValid: Validations.isPasswordValid(state.password),
      isMobileNumberValid: Validations.isMobileNumberValid(state.mobileNumber),
      isAllInputsValid: validateAllInputs(),
    );
  }
}

abstract class RegisterViewModelInputs {
  void onCountryMobileCodeChanged(String countryMobileCode);
  void onUserNameChanged(String userName);
  void onEmailChanged(String email);
  void onPasswordChanged(String password);
  void onMobileNumberChanged(String mobileNumber);
  void onRegister({required VoidCallback onDone});
}
