import 'package:flutter/material.dart';
import 'package:three_connects/presentation/screen/cart_modual/cart_screen.dart';
import 'package:three_connects/presentation/screen/sign_up_modual/signup_screen.dart';
import 'package:three_connects/utils/value_notifier.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isCart,
      builder: (context, value, child) {
        return value ? const CartScreen() : const SignUpScreen();
      },
    );
  }
}
