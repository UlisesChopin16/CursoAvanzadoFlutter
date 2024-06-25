import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/data/mapper/mapper.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_renderer.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

class LoadingState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;

  LoadingState({
    required this.stateRendererType,
    this.message = StringsManager.loading,
  });

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

class ErrorState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;

  ErrorState({
    required this.stateRendererType,
    required this.message,
  });

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

class ContentState extends FlowState {
  ContentState();

  @override
  StateRendererType getStateRendererType() => StateRendererType.CONTENT_SCREEN_STATE;

  @override
  String getMessage() => empty;
}

class EmptyState extends FlowState {
  final String messsage;
  EmptyState({
    required this.messsage,
  });

  @override
  StateRendererType getStateRendererType() => StateRendererType.EMPTY_SCREEN_STATE;

  @override
  String getMessage() => messsage;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
    BuildContext context,
    Widget contentScreenWidget,
    Function retryActionFunction,
  ) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() != StateRendererType.POPUP_LOADING_STATE) {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
          showPopUp(context, getStateRendererType(), getMessage(), retryActionFunction);
          return contentScreenWidget;
        }
      case ErrorState:
        {
          dismissPopUp(context);
          if (getStateRendererType() != StateRendererType.POPUP_ERROR_STATE) {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
          showPopUp(context, getStateRendererType(), getMessage(), retryActionFunction);
          return contentScreenWidget;
        }
      case ContentState:
        {
          dismissPopUp(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  void dismissPopUp(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  // Modal route es una clase que se encarga de manejar las rutas de la aplicación
  // isCurrent es un método que devuelve un booleano si la ruta actual es la que se está mostrando
  bool _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  void showPopUp(BuildContext context, StateRendererType stateRendererType, String message, Function? retryActionFunction) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: retryActionFunction,
          );
        },
      );
    });
  }
}
