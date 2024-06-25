import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/login/login_view_model/login_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:curso_avanzado_flutter/presentation/hooks/form_hook.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/widgets.dart';

class LoginView extends ConsumerWidget {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (flowState) = ref.watch(loginViewModelProvider.select((value) => value.flowState));

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: flowState?.getScreenWidget(
            context,
            const ViewLogin(),
            ref.read(loginViewModelProvider.notifier).retryAction,
          ) ??
          const ViewLogin(),
    );
  }
}

class ViewLogin extends HookConsumerWidget {
  const ViewLogin({
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
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(AppPadding.p20),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(
                        ImageAssets.splashLogo,
                      ),
                    ),
                    Gap(AppSize.s28),
                    FormComponent(),
                    Gap(AppSize.s8),
                    ForgotRegisterComponent(),
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
