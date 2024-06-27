import 'package:country_code_picker/country_code_picker.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/register/register_view_model/register_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/routes/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
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
    final emailNameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final mobileNumberController = useTextEditingController();

    final (
      emailValid,
      userNameValid,
      passwordValid,
      mobileNumberValid,
      allInputsValid,
    ) = ref.watch(
      registerViewModelProvider.select(
        (value) => (
          value.isEmailValid,
          value.isUserNameValid,
          value.isPasswordValid,
          value.isMobileNumberValid,
          value.isAllInputsValid,
        ),
      ),
    );

    return Column(
      children: [
        Padding(
          padding: padding,
          child: TextFormField(
            controller: userNameController,
            onChanged: ref.read(registerViewModelProvider.notifier).onUserNameChanged,
            decoration: InputDecoration(
              hintText: StringsManager.username,
              labelText: StringsManager.username,
              errorText: (userNameValid) ? null : StringsManager.usernameError,
            ),
          ),
        ),
        const Gap(AppSize.s12),
        Padding(
          padding: padding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: AppPadding.p8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorManager.grey,
                    width: AppSize.s1_5,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                ),
                child: CountryCodePicker(
                  onChanged: (country) {
                    // update view model with the selected code
                    ref
                        .read(registerViewModelProvider.notifier)
                        .onCountryMobileCodeChanged(country.dialCode ?? '+52');
                  },
                  padding: EdgeInsets.zero,
                  initialSelection: "+52",
                  showCountryOnly: true,
                  hideMainText: true,
                  showOnlyCountryWhenClosed: true,
                  favorite: const ['+52', '+1', '+34', '+56', '+57', '+58'],
                ),
              ),
              Expanded(
                flex: 3,
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: mobileNumberController,
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    hintText: StringsManager.mobileNumber,
                    labelText: StringsManager.mobileNumber,
                    errorText: (mobileNumberValid) ? null : StringsManager.invalidMobileNumber,
                  ),
                  onChanged: ref.read(registerViewModelProvider.notifier).onMobileNumberChanged,
                ),
              ),
            ],
          ),
        ),
        const Gap(AppSize.s12),
        Padding(
          padding: padding,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailNameController,
            onChanged: ref.read(registerViewModelProvider.notifier).onEmailChanged,
            decoration: InputDecoration(
              hintText: StringsManager.emailHint,
              labelText: StringsManager.emailHint,
              errorText: (emailValid) ? null : StringsManager.invalidEmail,
            ),
          ),
        ),
        const Gap(AppSize.s12),
        Padding(
          padding: padding,
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: passwordController,
            onChanged: ref.read(registerViewModelProvider.notifier).onPasswordChanged,
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
                      ref.read(registerViewModelProvider.notifier).onRegister(
                        onDone: () {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pop(true);
                            Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
                          });
                        },
                      );
                    }
                  : null,
              child: Text(
                StringsManager.register,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
