import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/domain/models/home_response_model/home_content_response_model.dart';
import 'package:curso_avanzado_flutter/presentation/routes/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListItemsComponent extends StatelessWidget {
  final List<HomeContentResponseModel>? items;
  const ListItemsComponent({
    super.key,
    this.items = const [],
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items?.length ?? 0,
        itemBuilder: (context, index) {
          final item = items![index];
          return InkWell(
            onTap: () {
              // print(context.debugDoingBuild);

              context.pushNamed(
                Routes.storeDetailsRouteName,
              );
            },
            child: Card(
              elevation: AppSize.s4,
              margin:
                  const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12),
                side: const BorderSide(
                  color: ColorManager.white,
                  width: AppSize.s1_5,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      child: Image.network(
                        item.image,
                        fit: BoxFit.cover,
                        width: AppSize.s140,
                        height: AppSize.s120,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p8),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
