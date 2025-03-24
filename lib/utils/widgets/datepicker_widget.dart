import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'button_widget.dart';

class CustomDatePicker extends StatefulWidget {
  final String header;
  final DateTime initialDateTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final ValueChanged<DateTime> onDateTimeChanged;
  final CupertinoDatePickerMode mode;

  const CustomDatePicker({
    super.key,
    required this.header,
    required this.initialDateTime,
    this.minimumDate,
    this.maximumDate,
    required this.onConfirm,
    required this.onCancel,
    required this.onDateTimeChanged,
    this.mode = CupertinoDatePickerMode.date,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  Timer? _debounceTimer;
  late DateTime _selectedDate;

  static const _spacing = SizedBox(height: 16);
  static const _cancelText = Text('বাতিল');

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDateTime;
  }

  @override
  void dispose() {
    _cancelDebounce();
    super.dispose();
  }

  void _cancelDebounce() {
    _debounceTimer?.cancel();
    _debounceTimer = null;
  }

  void _onDateChanged(DateTime date) {
    _selectedDate = date;
    _cancelDebounce();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        widget.onDateTimeChanged(_selectedDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height / 2.8,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.header,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          _spacing,
          Expanded(
            child: CupertinoDatePicker(
              mode: widget.mode,
              initialDateTime: widget.initialDateTime,
              minimumDate: widget.minimumDate,
              maximumDate: widget.maximumDate,
              onDateTimeChanged: _onDateChanged,
              use24hFormat: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  _cancelDebounce();
                  widget.onCancel();
                },
                child: _cancelText,
              ),
              ButtonWidget(
                title: 'ঠিক আছে',
                onPressed: () {
                  _cancelDebounce();
                  widget.onConfirm();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DatepickerWidget extends StatelessWidget {
  final String title;
  final String hint;
  final String header;
  final DateTime initialDateTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final ValueChanged<DateTime> onDateTimeChanged;
  final CupertinoDatePickerMode mode;

  static const _titleStyle = TextStyle(fontSize: 16);
  static const _spacing = SizedBox(height: 10);
  static const _iconStyle = TextStyle(
    fontSize: 12,
    color: Colors.black54,
    fontFamily: 'Ubuntu',
  );

  const DatepickerWidget({
    super.key,
    required this.title,
    required this.hint,
    required this.header,
    required this.initialDateTime,
    this.minimumDate,
    this.maximumDate,
    required this.onConfirm,
    required this.onCancel,
    required this.onDateTimeChanged,
    this.mode = CupertinoDatePickerMode.date,
  });

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      enableDrag: false,
      isDismissible: false,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) => CustomDatePicker(
        header: header,
        initialDateTime: initialDateTime,
        onDateTimeChanged: onDateTimeChanged,
        minimumDate: minimumDate,
        maximumDate: maximumDate,
        onConfirm: onConfirm,
        onCancel: onCancel,
        mode: mode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: _titleStyle),
        _spacing,
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _showDatePicker(context),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.black54,
                      size: 14,
                    ),
                    const SizedBox(width: 10),
                    Text(hint, style: _iconStyle),
                  ],
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
