import 'package:absence_schedule/common/models/student.dart';
import 'package:absence_schedule/features/absence_schedule/views/absence_schedule_view/table_details_button.dart';
import 'package:absence_schedule/features/absence_schedule/views/absence_schedule_view/table_name_item.dart';
import 'package:flutter/material.dart';

import 'table_item.dart';

customTableRow({
  required int studentIndex,
  required Student student,
  required TextEditingController controller,
  required Function(String name) onNameChange,
}) {
  return TableRow(
    children: [
      TableItem(data: (studentIndex + 1).toString()),
      TableNameItem(
        name: student.name,
        onChange: onNameChange,
        controller: controller,
      ),
      ...List.generate(
        student.daysStates.length,
        (dayIndex) => TableDetailsButton(
          dayIndex: dayIndex,
          studentIndex: studentIndex,
        ),
      ),
    ],
  );
}
