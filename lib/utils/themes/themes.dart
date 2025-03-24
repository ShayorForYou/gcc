import 'package:flutter/material.dart';
import 'package:gcc_portal/app_config.dart';

class Themes {
  static var lightTheme = ThemeData(
      fontFamily: AppAssets.fontNikosh,
      scaffoldBackgroundColor: Colors.grey.shade50,

      // textTheme: Theme.of(context).textTheme.apply(
      //       fontSizeFactor: .9,
      //       fontFamily: 'Nikosh',
      //       // fontSizeDelta: 2,
      //     ),
      colorScheme: const ColorScheme.light(
          primary: Colors.green, secondary: Colors.white),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade50,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: AppAssets.fontNikosh),
        bodySmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            fontFamily: AppAssets.fontNikosh),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 15))));
}
