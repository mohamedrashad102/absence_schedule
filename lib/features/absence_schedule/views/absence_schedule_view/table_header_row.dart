import 'package:absence_schedule/features/absence_schedule/views/absence_schedule_view/table_item.dart';
import 'package:flutter/material.dart';

tableHeaderRow(int length) {
  return TableRow(
    children: [
      const TableItem(data: 'الرقم'),
      const TableItem(data: 'الاسم'),
      ...List.generate(
        length,
        (index) => TableItem(data: '${index + 1}'),
      ),
    ],
  );
}
