import 'dart:ui';

import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function onConfirm;
  final Function onCancel;

  const CustomDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.onConfirm,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
              onPressed: () {
                onCancel();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary),
              ),
              child: Text(
                'না',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )),
          OutlinedButton(
              onPressed: () {
                onConfirm();
              },
              child: Text(
                'হ্যাঁ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              )),
        ],
      ),
    );
  }

  static Future show(
      {required BuildContext context,
      required String title,
      required String content,
      required Function onConfirm,
      required Function onCancel}) {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            title: title,
            content: content,
            onConfirm: onConfirm,
            onCancel: onCancel,
          );
        });
  }
}
