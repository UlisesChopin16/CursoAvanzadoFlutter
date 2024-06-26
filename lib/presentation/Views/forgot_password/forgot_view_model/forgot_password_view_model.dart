import 'package:curso_avanzado_flutter/app/di.dart';
import 'package:curso_avanzado_flutter/domain/usecase/forgot_password_use_case.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_renderer.dart';
import 'package:curso_avanzado_flutter/presentation/validations/validations.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forgot_password_view_model.freezed.dart';
part 'forgot_password_view_model.g.dart';

@freezed
class ForgotPasswordModel with _$ForgotPasswordModel {
  const factory ForgotPasswordModel({
    @Default('') String email,
    @Default(true) bool isEmailValid,
    @Default(false) bool isAllInputsValid,
    @Default(null) FlowState? flowState,
  }) = _ForgotPasswordModel;
}

@riverpod
class ForgotPasswordViewModel extends _$ForgotPasswordViewModel implements ForgotPasswordViewModelInputs{
  final ForgotPasswordUseCase _forgotPasswordUseCase = instance<ForgotPasswordUseCase>();

  @override
  ForgotPasswordModel build() {
    return const ForgotPasswordModel();
  }
  
  @override
  void onEmailChanged(String email) {
    state = state.copyWith(
      email: email.trim(),
    );
    _validate();
  }
  
  @override
  void onSendEmail({required VoidCallback onDone}) async {
    state = state.copyWith(
      flowState: LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
      ),
    );
    final response = await _forgotPasswordUseCase.execute(
      ForgotPasswordUseCaseInput(
        email: state.email,
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
      (forgotPasswordModelRep) {
        state = state.copyWith(
          flowState: SuccessState(
            stateRendererType: StateRendererType.POPUP_SUCCESS,
            title: forgotPasswordModelRep.message,
            message: 'Your new password is ${forgotPasswordModelRep.password}',
          ),
        );
        onDone();
      },
    );
  }
  
  @override
  void onRetry() {
    state = state.copyWith(
      flowState: ContentState(),
    );
  }

  // method to validate the email its an email
  void _validate() {
    state = state.copyWith(
      isEmailValid: Validations.isEmailValid(state.email),
      isAllInputsValid: Validations.isEmailValid(state.email),
    );
  }

  
}

abstract class ForgotPasswordViewModelInputs {
  void onEmailChanged(String email);
  void onSendEmail({required VoidCallback onDone});
  void onRetry();
}
