import 'package:curso_avanzado_flutter/presentation/Views/main/pages/home_page/store_details_page/store_details_page_view_model/store_details_page_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:curso_avanzado_flutter/presentation/hooks/use_launch_effect.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StoreDetailsPage extends HookConsumerWidget {
  const StoreDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useLaunchEffect(
      ref.read(storeDetailsPageViewModelProvider.notifier).getStoreDetails,
    );
    print('StoreDetailsPage');
    final (flowState) =
        ref.watch(storeDetailsPageViewModelProvider.select((value) => (value.flowState)));
    return Scaffold(
        body: flowState?.getScreenWidget(
      context,
      const Center(
        child: Text('Store Details'),
      ),
      ref.read(storeDetailsPageViewModelProvider.notifier).getStoreDetails,
    ));
  }
}
