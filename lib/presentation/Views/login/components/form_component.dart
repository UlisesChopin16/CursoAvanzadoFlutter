import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/login/login_view_model/login_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/routes/routes_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormComponent extends HookConsumerWidget {
  const FormComponent({super.key});

  static const padding = EdgeInsets.only(
    left: AppPadding.p28,
    right: AppPadding.p28,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNameController = useTextEditingController();
    final passwordController = useTextEditingController();

    final (userValid, passwordValid, allInputsValid) = ref.watch(
      loginViewModelProvider.select(
        (value) => (
          value.isUserNameValid,
          value.isPasswordValid,
          value.isAllInputsValid,
        ),
      ),
    );

    return Column(
      children: [
        Padding(
          padding: padding,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: userNameController,
            onChanged: (value) {
              ref.read(loginViewModelProvider.notifier).setUserName(value);
            },
            decoration: InputDecoration(
              hintText: StringsManager.username.tr(),
              labelText: StringsManager.username.tr(),
              errorText: (userValid) ? null : StringsManager.usernameError.tr(),
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
              hintText: StringsManager.password.tr(),
              labelText: StringsManager.password.tr(),
              errorText: (passwordValid) ? null : StringsManager.passwordError.tr(),
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
                            context.pushReplacementNamed(Routes.mainRouteName);
                          });
                        },
                      );
                    }
                  : null,
              child: Text(
                StringsManager.login.tr(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
