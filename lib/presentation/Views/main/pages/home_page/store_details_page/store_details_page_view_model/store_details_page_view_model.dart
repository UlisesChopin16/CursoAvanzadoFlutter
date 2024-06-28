import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
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
class StoreDetailsPageViewModel extends _$StoreDetailsPageViewModel {
  @override
  StoreDetailsPageModel build() {
    return const StoreDetailsPageModel();
  }

  @override
  void getStoreDetails() {}
}

abstract class StoreDetailsPageViewModelInputs {
  void getStoreDetails();
}
