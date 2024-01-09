import 'package:absence_schedule/common/widgets/adaptive_layout.dart';
import 'package:absence_schedule/features/absence_schedule/cubit/absence_cubit/absence_cubit.dart';
import 'package:absence_schedule/features/absence_schedule/cubit/sections_cubit/sections_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/absence_cubit/absence_state.dart';

class AbsenceScheduleAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AbsenceScheduleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: _isMobile(context)
          ? BackButton(
              onPressed: () => _unSelectSection(context),
            )
          : IconButton(
              onPressed: () => _closeSection(context),
              icon: const Icon(Icons.close)),
      centerTitle: true,
      title: BlocBuilder<AbsenceCubit, AbsenceState>(
        builder: (context, state) {
          final absenceCubit = AbsenceCubit.of(context);
          return Text(absenceCubit.section.title);
        },
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;

  _unSelectSection(BuildContext context) {
    SectionsCubit.of(context).unSelectOldSection();
    AbsenceCubit.of(context).initial();
    Navigator.pop(context);
  }

  _closeSection(BuildContext context) {
    SectionsCubit.of(context).unSelectOldSection();
    AbsenceCubit.of(context).initial();
  }

  _isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < AdaptiveLayout.mobileBreakPoint;
  }
}
