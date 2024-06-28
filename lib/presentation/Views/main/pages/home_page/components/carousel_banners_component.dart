import 'package:carousel_slider/carousel_slider.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/pages/home_page/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarouselBannersComponent extends ConsumerWidget {
  const CarouselBannersComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (banners) = ref.watch(
      homeViewModelProvider.select(
        (value) => (value.homeResponseModel?.data.banners),
      ),
    );
    return CarouselSlider(
      items: banners
          ?.map(
            (banners) => SizedBox(
              width: double.infinity,
              child: Card(
                elevation: AppSize.s1_5,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: ColorManager.white,
                    width: AppSize.s1_5,
                  ),
                  borderRadius: BorderRadius.circular(AppSize.s12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  child: Image.network(
                    banners.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: AppSize.s190,
        autoPlay: true,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
      ),
    );
  }
}
