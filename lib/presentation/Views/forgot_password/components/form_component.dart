import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/forgot_password/forgot_view_model/forgot_password_view_model.dart';
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
    final emailNameController = useTextEditingController();

    final (emailValid, allInputsValid) = ref.watch(
      forgotPasswordViewModelProvider.select(
        (value) => (
          value.isEmailValid,
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
            controller: emailNameController,
            onChanged: ref.read(forgotPasswordViewModelProvider.notifier).onEmailChanged,
            decoration: InputDecoration(
              hintText: StringsManager.emailHint.tr(),
              labelText: StringsManager.emailHint.tr(),
              errorText: (emailValid) ? null : StringsManager.invalidEmail.tr(),
            ),
          ),
        ),
        const Gap(AppSize.s28 + AppSize.s16),
        Padding(
          padding: padding,
          child: SizedBox(
            width: double.infinity,
            height: AppSize.s40,
            child: ElevatedButton(
              onPressed: (allInputsValid)
                  ? () {
                      ref.read(forgotPasswordViewModelProvider.notifier).onSendEmail(
                        onDone: () {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            context.pop();
                          });
                        },
                      );
                    }
                  : null,
              child: Text(
                StringsManager.resetPassword.tr(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
