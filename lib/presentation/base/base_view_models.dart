import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'base_view_models.freezed.dart';
part 'base_view_models.g.dart';

@freezed
class FlowStateModel with _$FlowStateModel {
  const factory FlowStateModel({
    @Default(null) FlowState? flowState,
  }) = _FlowStateModel;
}

@riverpod
class BaseViewModels extends _$BaseViewModels {

  @override
  FlowStateModel build() {
    return const FlowStateModel();
  }

  void changeFlowState(FlowState flowState) {
    state = state.copyWith(flowState: flowState);
  }

  // shared variables and functions thah will be used throughout any view model
  // StreamController<FlowState> flowStateController = StreamController<FlowState>.broadcast();
}
