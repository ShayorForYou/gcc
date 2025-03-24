import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app_config.dart';

InputDecoration textFieldDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.redAccent,
      width: 0.4,
    ),
  ),
  hintStyle:
      const TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Nikosh'),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  ),
  filled: true,
  fillColor: Colors.grey.withOpacity(0.2),
);

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final bool obscureText;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final InputDecoration? decoration;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final bool? readOnly;
  final bool? enabled;
  final bool isRequired;

  const CustomTextField(
      {super.key,
      this.controller,
      required this.title,
      this.obscureText = false,
      this.autovalidateMode,
      this.inputFormatters,
      this.validator,
      this.decoration,
      this.textInputAction,
      this.keyboardType,
      this.maxLines,
      this.minLines,
      this.readOnly,
      this.enabled,
      this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: isRequired ? ' *' : '',
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          style:
              const TextStyle(fontSize: 16, fontFamily: AppAssets.fontUbuntu),
          controller: controller,
          obscureText: obscureText,
          autovalidateMode: autovalidateMode,
          inputFormatters: inputFormatters,
          validator: validator,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          maxLines: maxLines,
          minLines: minLines,
          readOnly: readOnly ?? false,
          enabled: enabled ?? true,
          decoration: decoration ?? textFieldDecoration,
        ),
      ],
    );
  }
}
