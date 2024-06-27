// ignore_for_file: constant_identifier_names
import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/font_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/styles_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/data/mapper/customer_mapper.dart';
import 'package:curso_avanzado_flutter/data/network/failures/failure.dart';
import 'package:curso_avanzado_flutter/presentation/common/components/animated_image_component.dart';
import 'package:curso_avanzado_flutter/presentation/common/components/dialog_component.dart';
import 'package:flutter/material.dart';

enum StateRendererType {
  // POPUP STATES
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  POPUP_SUCCESS,
  // FULL SCREEN STATES
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE, // THE UI OF THE SCREEN
  EMPTY_SCREEN_STATE // EMPTY VIEW WHEN WE RECEIVE NO DATA FROM API SIDE FOR LIST SCREEN
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function? retryActionFunction;

  const StateRenderer({
    super.key,
    required this.stateRendererType,
    required this.retryActionFunction,
    Failure? failure,
    String? message,
    String? title,
  })  : message = message ?? StringsManager.loading,
        title = title ?? empty;

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return DialogComponent(
          children: [
            const AnimatedImageComponent(animationName: JsonAssets.loading),
            _getMessage(message),
          ],
        );
      case StateRendererType.POPUP_ERROR_STATE:
        return DialogComponent(
          children: [
            const AnimatedImageComponent(animationName: JsonAssets.error),
            _getMessage(message),
            RetryButton(
              stateRendererType: stateRendererType,
              retryActionFunction: retryActionFunction,
              buttonTitle: StringsManager.ok,
            ),
          ],
        );
      case StateRendererType.POPUP_SUCCESS:
        return DialogComponent(
          children: [
            const AnimatedImageComponent(animationName: JsonAssets.success),
            _getMessage(title),
            _getMessage(message),
            RetryButton(
              stateRendererType: stateRendererType,
              retryActionFunction: retryActionFunction,
              buttonTitle: StringsManager.ok,
            )
          ],
        );
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn(
          [
            const AnimatedImageComponent(animationName: JsonAssets.loading),
            _getMessage(message),
          ],
        );
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn(
          [
            const AnimatedImageComponent(animationName: JsonAssets.error),
            _getMessage(message),
            RetryButton(
              stateRendererType: stateRendererType,
              retryActionFunction: retryActionFunction,
            )
          ],
        );
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsInColumn(
          [
            const AnimatedImageComponent(animationName: JsonAssets.empty),
            _getMessage(message),
          ],
        );
      default:
        return Container();
    }
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style: getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16),
        ),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class RetryButton extends StatelessWidget {
  const RetryButton({
    super.key,
    required this.stateRendererType,
    required this.retryActionFunction,
    this.buttonTitle = StringsManager.retryAgain,
  });

  final String buttonTitle;
  final StateRendererType stateRendererType;
  final Function? retryActionFunction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
            onPressed: () {
              if (stateRendererType == StateRendererType.FULL_SCREEN_ERROR_STATE ||
                  stateRendererType == StateRendererType.POPUP_ERROR_STATE) {
                retryActionFunction?.call(); // to call the API function again to retry
              } else {
                Navigator.of(context).pop(); // popup state error so we need to dismiss the dialog
              }
            },
            child: Text(
              buttonTitle,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
      ),
    );
  }
}
