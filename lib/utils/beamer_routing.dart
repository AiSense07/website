import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:three_connects/presentation/screen/cart_modual/edit_address.dart';
import 'package:three_connects/presentation/screen/home_screen.dart';
import 'package:three_connects/presentation/screen/product_list_screen.dart';
import 'package:three_connects/presentation/screen/sign_up_modual/signup_screen.dart';
import 'package:three_connects/utils/navigation_string.dart';
import '../presentation/screen/product_screen/product_screen.dart';

final routerDelegate = BeamerDelegate(
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/': (context, state, data) => beamPage("", const HomeScreen()),
      '/${Routes.login}': (context, state, data) => beamPage(
            Routes.login,
            const SignUpScreen(),
          ),
      '/${Routes.registration}': (context, state, data) => beamPage(
            Routes.registration,
            const SignUpScreen(),
          ),
      '/${Routes.spare}': (context, state, data) => beamPage(
            Routes.spare,
            const ProductList(path: Routes.spare),
          ),
      '/${Routes.filament}': (context, state, data) => beamPage(
            Routes.filament,
            const ProductList(path: Routes.filament),
          ),
      '/3d-printed-parts?category=cat&subcategory=subcat&manufacture=man&page=no':
          (context, state, _) {
        Map<String, dynamic> data = state.queryParameters;
        return beamPage(
          'category-${data['subcategory']}-${data['page']}',
          ProductList(
            path: Routes.parts,
            cat: data['id'],
            page: int.parse(data['page'] ?? "0"),
          ),
        );
      },
      '/${Routes.design}': (context, state, data) => beamPage(
            Routes.design,
            const ProductList(path: Routes.design),
          ),
      '/Home?product=id': (context, state, data) => beamPage(
            "${Routes.product}-${state.queryParameters['product']}",
            ProductScreen(productId: state.queryParameters['product'] ?? ""),
          ),
      '/${Routes.address}': (context, state, data) => beamPage(
            Routes.address,
            const EditAddress(addressID: "", address: "", landmark: "", tag: ""),
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
/*
      '/${Routes.design}?product=id': (context, state, data) => beamPage(
            Routes.design,
            ProductScreen(productId: state.queryParameters['product'] ?? ""),
          ),
      '/${Routes.spare}?product=id': (context, state, data) => beamPage(
        Routes.spare,
        ProductScreen(productId: state.queryParameters['product'] ?? ""),
      ),
      '/${Routes.filament}?product=id': (context, state, data) => beamPage(
        Routes.filament,
        ProductScreen(productId: state.queryParameters['product'] ?? ""),
      ),
      '/3d-printed-parts?product=id': (context, state, data) => beamPage(
        Routes.parts,
        ProductScreen(productId: state.queryParameters['product'] ?? ""),
      ),
 */
