import 'dart:async';
import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';

abstract class BaseViewModels implements BaseViewModelInputs, BaseViewModelOutputs {
  // shared variables and functions thah will be used throughout any view model
  StreamController<FlowState> flowStateController = StreamController<FlowState>.broadcast();

  @override
  Sink<FlowState> get inputFlowState => flowStateController.sink;

  @override
  Stream<FlowState> get outputFlowState => flowStateController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    flowStateController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); // will be called while init of view model
  void dispose(); // will be called while disposing of view model

  Sink<FlowState> get inputFlowState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputFlowState;
}
