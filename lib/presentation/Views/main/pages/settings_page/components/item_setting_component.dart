import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/language_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/common/components/title_component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

class ItemSettingComponent extends ConsumerWidget {
  final String title;
  final String assetName;
  final void Function(BuildContext)? onTap;

  const ItemSettingComponent({super.key, this.onTap, required this.title, required this.assetName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0.5,
      child: ListTile(
        title: TitleRegularComponent(text: title.tr()),
        leading: SvgPicture.asset(
          assetName,
          width: AppSize.s40,
        ),
        trailing: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(isRtl(context) ? math.pi : 0),
          child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
        ),
        onTap: () {
          onTap?.call(context);
        },
      ),
    );
  }

  bool isRtl(BuildContext context) {
    return context.locale == ARABIC_LOCAL;
  }
}
