import 'package:absence_schedule/features/absence_schedule/cubit/absence_cubit/absence_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/absence_cubit/absence_state.dart';
import 'absence_schedule_app_bar.dart';
import 'custom_table.dart';
import 'custom_table_row.dart';
import 'table_header_row.dart';

class AbsenceScheduleView extends StatelessWidget {
  const AbsenceScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceCubit, AbsenceState>(
      builder: (context, state) {
        if (state is AbsenceSuccessState) {
          final absenceCubit = AbsenceCubit.of(context);
          return Scaffold(
            appBar: const AbsenceScheduleAppBar(),
            body: CustomTable(
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
            ),
          );
        } else if (state is AbsenceLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const SizedBox();
      },
    );
  }
}
