import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:three_connects/presentation/screen/product_list_screen.dart';
import 'package:three_connects/utils/navigation_string.dart';
import '../presentation/screen/home_screen.dart';
import '../presentation/screen/product_screen/product_screen.dart';

final routerDelegate = BeamerDelegate(
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/': (context, state, data) => beamPage("", const HomeScreen()),
      '/${Routes.spare}': (context, state, data) => beamPage(
            Routes.spare,
            const ProductList(path: Routes.spare),
          ),
      '/${Routes.filament}': (context, state, data) => beamPage(
            Routes.filament,
            const ProductList(path: Routes.filament),
          ),
      '/${Routes.nozzles}': (context, state, data) => beamPage(
            Routes.nozzles,
            const ProductList(path: Routes.nozzles),
          ),
      '/${Routes.design}': (context, state, data) => beamPage(
            Routes.design,
            const ProductList(path: Routes.design),
          ),
      '/Home?product=id': (context, state, data) => beamPage(
            Routes.design,
            ProductScreen(productId: state.queryParameters['product']!),
          ),
    },
  ),
);

BeamPage beamPage(String path, Widget page) {
  return BeamPage(
    key: ValueKey(path),
    title: '3D Connect',
    popToNamed: '/$path',
    type: BeamPageType.noTransition,
    child: page,
  );
}
