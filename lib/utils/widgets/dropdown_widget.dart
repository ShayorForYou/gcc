import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String? title;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final Color color;
  final bool isRequired;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final String? hint;

  const CustomDropdown({
    super.key,
    this.title,
    required this.items,
    required this.value,
    this.color = Colors.grey,
    this.isRequired = false,
    required this.onChanged,
    this.validator,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final titleWidget = title == null
        ? const SizedBox.shrink()
        : Text.rich(
            TextSpan(
              text: title,
              style: const TextStyle(
                fontSize: 16,
              ),
              children: [
                if (isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          );

    final dropdownStyleData = DropdownStyleData(
      maxHeight: MediaQuery.of(context).size.height * .3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 1,
    );

    final buttonStyleData = ButtonStyleData(
      padding: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: value == null
              ? isRequired
                  ? Colors.redAccent.withOpacity(0.5)
                  : Colors.grey
              : color,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        titleWidget,
        if (title != null) const SizedBox(height: 10),
        DropdownButtonHideUnderline(
          child: DropdownButton2<T>(
            dropdownStyleData: dropdownStyleData,
            isExpanded: true,
            hint: hint != null ? Text(hint!) : null,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
            items: items,
            onChanged: onChanged,
            value: value,
            buttonStyleData: buttonStyleData,
          ),
        ),
      ],
    );
  }
}
