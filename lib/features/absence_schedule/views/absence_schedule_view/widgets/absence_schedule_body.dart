import 'package:absence_schedule/features/absence_schedule/cubit/absence_cubit/absence_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/absence_cubit/absence_cubit.dart';
import 'custom_table.dart';
import 'custom_table_row.dart';
import 'table_header_row.dart';

class AbsenceScheduleBody extends StatelessWidget {
  const AbsenceScheduleBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceCubit, AbsenceState>(
      builder: (context, state) {
        final absenceCubit = AbsenceCubit.of(context);
        return CustomTable(
          children: [
            tableHeaderRow(
                absenceCubit.section.students.first.daysStates.length),
            ...absenceCubit.section.students.asMap().entries.map(
                  (entry) => customTableRow(
                    studentIndex: entry.key,
                    student: entry.value,
                    controller: absenceCubit.controllers[entry.key],
                    onNameChange: (name) => absenceCubit.changeStudentName(
                      name: name,
                      studentIndex: entry.key,
                    ),
                  ),
                ),
          ],
        );
      },
    );
  }
}
