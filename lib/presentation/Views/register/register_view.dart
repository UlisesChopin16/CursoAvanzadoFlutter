import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/styles_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/register/register_view_model/register_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:curso_avanzado_flutter/presentation/common/components/text_button_component.dart';
import 'package:curso_avanzado_flutter/presentation/hooks/form_hook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/widgets.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (flowState) = ref.watch(registerViewModelProvider.select((value) => value.flowState));
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ColorManager.white,
      body: flowState?.getScreenWidget(
            context,
            const ViewRegister(),
            ref.read(registerViewModelProvider.notifier).retryAction,
          ) ??
          const ViewRegister(),
    );
  }
}

class ViewRegister extends HookConsumerWidget {
  const ViewRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useFormStateKey();
    final (image) = ref.watch(registerViewModelProvider.select((value) => value.profilePicture));

    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p30),
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
                    Text(
                      StringsManager.profilePicture,
                      style: getMediumStyle(color: ColorManager.darkGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showPicker(context, ref);
                      },
                      child: CircleAvatar(
                        radius: AppSize.s100,
                        backgroundColor: ColorManager.lightGrey2,
                        backgroundImage: image == null ? null : FileImage(image),
                        child: image == null
                            ? Padding(
                                padding: const EdgeInsets.all(AppPadding.p20),
                                child: SvgPicture.asset(
                                  ImageAssets.photoCameraIc,
                                  width: AppSize.s60,
                                  height: AppSize.s60,
                                ),
                              )
                            : null
                      ),
                    ),

                    // const Image(
                    //   image: AssetImage(
                    //     ImageAssets.splashLogo,
                    //   ),
                    // ),
                    const Gap(AppSize.s28),
                    const FormComponent(),
                    const Gap(AppSize.s12),
                    TextButtonComponent(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      text: StringsManager.haveAccount,
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

  void _showPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: const Text(StringsManager.photoGallery),
                onTap: () async {
                  await ref.read(registerViewModelProvider.notifier).imageFromGallery();
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_rounded),
                title: const Text(StringsManager.photoCamera),
                onTap: () async {
                  await ref.read(registerViewModelProvider.notifier).imageFromCamera();
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
