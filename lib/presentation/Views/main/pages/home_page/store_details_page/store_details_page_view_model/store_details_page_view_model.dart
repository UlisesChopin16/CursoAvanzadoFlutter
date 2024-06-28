import 'package:curso_avanzado_flutter/app/di.dart';
import 'package:curso_avanzado_flutter/domain/usecase/store_details_use_case.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_renderer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_details_page_view_model.freezed.dart';
part 'store_details_page_view_model.g.dart';

@freezed
class StoreDetailsPageModel with _$StoreDetailsPageModel {
  const factory StoreDetailsPageModel({
    @Default('') String imageUrl,
    @Default('') String title,
    @Default('') String details,
    @Default('') String services,
    @Default('') String about,
    @Default(null) FlowState? flowState,
  }) = _StoreDetailsPageModel;
}

@riverpod
class StoreDetailsPageViewModel extends _$StoreDetailsPageViewModel implements StoreDetailsPageViewModelInputs{

  final StoreDetailsUseCase _storeDetailsUseCase = instance<StoreDetailsUseCase>();
  @override
  StoreDetailsPageModel build() {
    return const StoreDetailsPageModel();
  }

  @override
  void getStoreDetails() async {
    state = state.copyWith(
      flowState: LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE,
      ),
    );

    final response = await _storeDetailsUseCase.execute(null);

    response.fold(
      (failure) {
        state = state.copyWith(
          flowState: ErrorState(
            stateRendererType: StateRendererType.FULL_SCREEN_ERROR_STATE,
            message: failure.message,
          ),
        );
      },
      (storeDetailsResponseModel) {
        state = state.copyWith(
          imageUrl: storeDetailsResponseModel.image,
          title: storeDetailsResponseModel.title,
          details: storeDetailsResponseModel.details,
          services: storeDetailsResponseModel.services,
          about: storeDetailsResponseModel.about,
          flowState: ContentState(),
        );
      },
    );
  }
}

abstract class StoreDetailsPageViewModelInputs {
  void getStoreDetails();
}
