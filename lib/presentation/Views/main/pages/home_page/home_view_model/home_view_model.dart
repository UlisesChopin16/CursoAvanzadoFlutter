import 'package:curso_avanzado_flutter/app/di.dart';
import 'package:curso_avanzado_flutter/domain/models/home_response_model/home_response_model.dart';
import 'package:curso_avanzado_flutter/domain/usecase/home_use_case.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_renderer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.freezed.dart';
part 'home_view_model.g.dart';

@freezed
class HomeModel with _$HomeModel {
  const factory HomeModel({
    @Default(null) HomeResponseModel? homeResponseModel,
    @Default(null) FlowState? flowState,
  }) = _HomeModel;
}

@riverpod
class HomeViewModel extends _$HomeViewModel implements HomeViewModelInputs {
  final HomeUseCase _homeUseCase = instance<HomeUseCase>();

  @override
  HomeModel build() {
    return const HomeModel();
  }

  @override
  Future<void> dataHome() async {
    state = state.copyWith(
      flowState: LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE,
      ),
    );

    final response = await _homeUseCase.execute(null);

    response.fold(
      (failure) {
        state = state.copyWith(
          flowState: ErrorState(
            stateRendererType: StateRendererType.FULL_SCREEN_ERROR_STATE,
            message: failure.message,
          ),
        );
      },
      (homeResponseModel) {
        state = state.copyWith(
          homeResponseModel: homeResponseModel,
          flowState: ContentState(),
        );
      },
    );
  }

  @override
  Future<void> onRetry() async {
    await dataHome();
  }
}

abstract class HomeViewModelInputs {
  Future<void> dataHome();
  Future<void> onRetry();
}
