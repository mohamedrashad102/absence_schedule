import 'package:flutter/material.dart';

import '../../absence_schedule_view/absence_schedule_view.dart';
import '../../sections_view/sections_view.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 7,
          child: AbsenceScheduleView(),
        ),
        Container(
          height: double.infinity,
          width: 0.7,
          color: Colors.grey.withOpacity(0.5),
        ),
        const Expanded(
          flex: 2,
          child: SectionsView(),
        ),
      ],
    );
  }
}
