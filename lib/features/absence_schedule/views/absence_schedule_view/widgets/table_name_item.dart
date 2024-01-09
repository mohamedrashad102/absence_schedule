import 'package:flutter/material.dart';

class TableNameItem extends StatelessWidget {
  const TableNameItem({
    super.key,
    required this.name,
    required this.onChange,
    required this.controller,
  });
  final String name;
  final TextEditingController controller;
  final void Function(String value) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
       controller: controller,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        maxLines: 1,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(0),
        ),
        onChanged: onChange,
      ),
    );
  }
}
