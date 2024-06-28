import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/common/components/title_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemSettingComponent extends StatelessWidget {
  final String title;
  final String assetName;
  final void Function()? onTap;

  const ItemSettingComponent({super.key, this.onTap, required this.title, required this.assetName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: ListTile(
        title: TitleRegularComponent(text: title),
        leading: SvgPicture.asset(
          assetName,
          width: AppSize.s40,
        ),
        trailing: SvgPicture.asset(
          ImageAssets.settingsRightArrowIc,
          width: AppSize.s20,
        ),
        onTap: onTap,
      ),
    );
  }
}
