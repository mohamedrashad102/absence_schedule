import 'package:absence_schedule/features/absence_schedule/cubit/absence_cubit/absence_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/absence_cubit/absence_state.dart';
import 'widgets/absence_schedule_app_bar.dart';
import 'widgets/absence_schedule_body.dart';

class AbsenceScheduleView extends StatelessWidget {
  const AbsenceScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceCubit, AbsenceState>(
      builder: (context, state) {
        if (state is AbsenceSuccessState) {
          return const Scaffold(
            appBar: AbsenceScheduleAppBar(),
            body: AbsenceScheduleBody(),
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
