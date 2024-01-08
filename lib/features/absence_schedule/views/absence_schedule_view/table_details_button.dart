import 'package:absence_schedule/features/absence_schedule/cubit/absence_cubit/absence_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/absence_cubit/absence_state.dart';

class TableDetailsButton extends StatelessWidget {
  const TableDetailsButton({
    super.key,
    required this.dayIndex,
    required this.studentIndex,
  });
  final int dayIndex;

  final int studentIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceCubit, AbsenceState>(
      builder: (context, state) {
        final cubit = AbsenceCubit.of(context);
        return IconButton(
          onPressed: () => _onPressed(cubit),
          icon: _getIcon(cubit),
        );
      },
    );
  }

  Widget _getIcon(AbsenceCubit absenceCubit) {
    if (absenceCubit
            .section.students[studentIndex].daysStates[dayIndex] ==
        null) {
      return const Text('');
    }
    if (absenceCubit
            .section.students[studentIndex].daysStates[dayIndex] ==
        true) {
      return const Icon(
        Icons.done,
        color: Colors.green,
      );
    }
    return const Icon(
      Icons.clear,
      color: Colors.red,
    );
  }

  void _onPressed(AbsenceCubit absenceCubit) {
    absenceCubit.changeDayState(
      dayIndex: dayIndex,
      studentIndex: studentIndex,
    );
  }
}
