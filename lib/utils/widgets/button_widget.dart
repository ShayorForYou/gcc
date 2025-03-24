import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback onPressed;

  const ButtonWidget({
    super.key,
    required this.title,
    this.buttonColor,
    this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          backgroundColor: buttonColor == null
              ? WidgetStateProperty.all(Theme.of(context).colorScheme.primary)
              : WidgetStateProperty.all(buttonColor),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 16,
            fontFamily: 'Nikosh',
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}

class ButtonWidgetWithIcon extends StatelessWidget {
  final String title;
  final Color? buttonColor;
  final Color? textColor;
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonWidgetWithIcon({
    super.key,
    required this.title,
    this.buttonColor,
    this.textColor,
    this.icon = Icons.refresh,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        icon: Icon(
          applyTextScaling: true,
          icon,
          color: Colors.white,
        ),
        label: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );
}
