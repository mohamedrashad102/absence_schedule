import 'package:flutter/material.dart';

class SectionTextForm extends StatelessWidget {
  const SectionTextForm({
    super.key,
    this.hintText,
    required this.onChanged,
  });

  final String? hintText;
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      textAlign: TextAlign.end,
      textDirection: TextDirection.rtl,
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText ?? 'أدخل اسم المجموعه',
      ),
      onChanged: onChanged,
    );
  }
}
