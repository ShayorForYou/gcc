import 'package:flutter/material.dart';

myHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

myWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Widget height2() => const SizedBox(height: 2);
Widget height5() => const SizedBox(height: 5);
Widget height10() => const SizedBox(height: 10);
Widget height15() => const SizedBox(height: 15);
Widget height20() => const SizedBox(height: 20);
Widget height25() => const SizedBox(height: 25);
Widget height30() => const SizedBox(height: 30);
Widget height40() => const SizedBox(height: 40);
Widget height50() => const SizedBox(height: 50);
Widget height55() => const SizedBox(height: 55);
Widget height60() => const SizedBox(height: 60);

Widget width2() => const SizedBox(width:2);
Widget width5() => const SizedBox(width: 5);
Widget width10() => const SizedBox(width: 10);
Widget width15() => const SizedBox(width: 15);
Widget width20() => const SizedBox(width: 20);
Widget width25() => const SizedBox(width: 25);
Widget width30() => const SizedBox(width: 30);
Widget width35() => const SizedBox(width: 35);
Widget width40() => const SizedBox(width: 40);
Widget width50() => const SizedBox(width: 50);

Widget keyboardPadding(BuildContext context) => Padding(
  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
);

double sizeByHeight(BuildContext context, double size) {
  return MediaQuery.of(context).size.height * size;
}

double sizeByWidth(BuildContext context, double size) {
  return MediaQuery.of(context).size.width * size;
}
