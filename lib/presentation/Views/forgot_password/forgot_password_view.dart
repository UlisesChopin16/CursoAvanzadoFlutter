import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/forgot_password/forgot_view_model/forgot_password_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:curso_avanzado_flutter/presentation/common/components/text_button_component.dart';
import 'package:curso_avanzado_flutter/presentation/hooks/form_hook.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/widgets.dart';

class ForgotPasswordView extends ConsumerWidget {
  const ForgotPasswordView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (flowState) =
        ref.watch(forgotPasswordViewModelProvider.select((value) => value.flowState));

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ColorManager.white,
      body: flowState?.getScreenWidget(
            context,
            const ForgotView(),
            ref.read(forgotPasswordViewModelProvider.notifier).onRetry,
          ) ??
          const ForgotView(),
    );
  }
}

class ForgotView extends HookConsumerWidget {
  const ForgotView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useFormStateKey();
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage(
                        ImageAssets.splashLogo,
                      ),
                    ),
                    const Gap(AppSize.s28),
                    const FormComponent(),
                    const Gap(AppSize.s12),
                    TextButtonComponent(
                      onPressed: () {},
                      text: StringsManager.resendEmail.tr(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
