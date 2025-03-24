import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';

class MyWidgets {
  BuildContext? context;

  MyWidgets({this.context});

  showToast({
    required String message,
    required IconData icon,
    required ToastificationType type,
    Duration duration = const Duration(seconds: 4),
  }) {
    toastification.show(
      description: Text(
        message,
        maxLines: 8,
        style: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),
      ),
      icon: const Icon(
        FontAwesomeIcons.circleInfo,
        size: 24,
        color: Colors.amber,
      ),
      style: ToastificationStyle.minimal,
      showProgressBar: false,
      type: ToastificationType.warning,
      backgroundColor: const Color(0xFF303030),
      dragToClose: true,
      closeButtonShowType: CloseButtonShowType.none,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: duration,
    );
  }
}
