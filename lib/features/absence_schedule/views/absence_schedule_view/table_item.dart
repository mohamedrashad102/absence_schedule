import 'package:flutter/material.dart';

class TableItem extends StatelessWidget {
  const TableItem({
    super.key,
    required this.data,
    this.alignment,
  });
  final String data;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Align(
        alignment: alignment ?? Alignment.center,
        child: Text(data),
      ),
    );
  }
}
