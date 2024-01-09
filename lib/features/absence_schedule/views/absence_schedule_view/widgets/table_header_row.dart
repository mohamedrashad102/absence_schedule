import 'package:flutter/material.dart';

import 'table_item.dart';

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
