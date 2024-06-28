import 'package:carousel_slider/carousel_slider.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/domain/models/home_response_model/home_content_response_model.dart';
import 'package:flutter/material.dart';

class ListItemsComponent extends StatelessWidget {
  final List<HomeContentResponseModel>? items;
  const ListItemsComponent({
    super.key,
    this.items = const [],
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: AppSize.s180,
        enlargeCenterPage: true,
        autoPlay: true,
        viewportFraction: 0.38,
        enableInfiniteScroll: true,
      ),
      items: items!
          .map(
            (item) => Card(
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
          )
          .toList(),
    );
  }
}
