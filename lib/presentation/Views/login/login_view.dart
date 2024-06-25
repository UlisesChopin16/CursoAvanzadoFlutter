import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/login/login_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:curso_avanzado_flutter/presentation/components/text_button_component.dart';
import 'package:curso_avanzado_flutter/presentation/hooks/form_hook.dart';
import 'package:curso_avanzado_flutter/presentation/routes/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

  static const padding = EdgeInsets.only(
    left: AppPadding.p28,
    right: AppPadding.p28,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useFormStateKey();

    final (userValid, passwordValid, allInputsValid) = ref.watch(
      loginViewModelProvider.select(
        (value) => (
          value.isUserNameValid,
          value.isPasswordValid,
          value.isAllInputsValid,
        ),
      ),
    );
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
                  children: [
                    const Image(
                      image: AssetImage(
                        ImageAssets.splashLogo,
                      ),
                    ),
                    const Gap(AppSize.s28),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: userNameController,
                        onChanged: (value) {
                          ref.read(loginViewModelProvider.notifier).setUserName(value);
                        },
                        decoration: InputDecoration(
                          hintText: StringsManager.username,
                          labelText: StringsManager.username,
                          errorText: (userValid) ? null : StringsManager.usernameError,
                        ),
                      ),
                    ),
                    const Gap(AppSize.s28),
                    Padding(
                      padding: padding,
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        onChanged: (value) {
                          ref.read(loginViewModelProvider.notifier).setPassword(value);
                        },
                        decoration: InputDecoration(
                          hintText: StringsManager.password,
                          labelText: StringsManager.password,
                          errorText: (passwordValid) ? null : StringsManager.passwordError,
                        ),
                      ),
                    ),
                    const Gap(AppSize.s28),
                    Padding(
                      padding: padding,
                      child: SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed: (allInputsValid)
                              ? () {
                                  ref.read(loginViewModelProvider.notifier).login(
                                    onDone: () {
                                      SchedulerBinding.instance.addPostFrameCallback((_) {
                                        Navigator.pushReplacementNamed(context, Routes.mainRoute);
                                      });
                                    },
                                  );
                                }
                              : null,
                          child: Text(
                            StringsManager.login,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ),
                    const Gap(AppSize.s8),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FORGOT PASSWORD
                          TextButtonComponent(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, Routes.forgotPasswordRoute);
                            },
                            text: StringsManager.forgetPassword,
                          ),
                          const Gap(AppSize.s8),
                          // REGISTER
                          Flexible(
                            child: TextButtonComponent(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, Routes.registerRoute);
                              },
                              text: StringsManager.registerText,
                            ),
                          ),
                        ],
                      ),
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
