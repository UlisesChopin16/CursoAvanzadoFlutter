import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/components/text_button_component.dart';
import 'package:curso_avanzado_flutter/presentation/routes/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ForgotRegisterComponent extends StatelessWidget {
  const ForgotRegisterComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              Navigator.of(context).pushNamed(Routes.forgotPasswordRoute);
            },
            text: StringsManager.forgetPassword,
          ),
          const Gap(AppSize.s8),
          // REGISTER
          Flexible(
            child: TextButtonComponent(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.registerRoute);
              },
              text: StringsManager.registerText,
            ),
          ),
        ],
      ),
    );
  }
}
