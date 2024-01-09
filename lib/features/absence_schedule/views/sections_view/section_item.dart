import 'package:absence_schedule/common/widgets/adaptive_layout.dart';
import 'package:absence_schedule/features/absence_schedule/cubit/absence_cubit/absence_cubit.dart';
import 'package:absence_schedule/features/absence_schedule/cubit/sections_cubit/sections_cubit.dart';
import 'package:absence_schedule/features/absence_schedule/cubit/sections_cubit/sections_state.dart';
import 'package:absence_schedule/features/absence_schedule/views/absence_schedule_view/absence_schedule_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/show_alert_dialog.dart';
import 'section_text_form.dart';

class SectionItem extends StatelessWidget {
  const SectionItem({
    super.key,
    required this.sectionIndex,
  });
  final int sectionIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionsCubit, SectionsState>(
      builder: (context, state) {
        final sectionsCubit = SectionsCubit.of(context);
        final absenceCubit = AbsenceCubit.of(context);
        final width = MediaQuery.sizeOf(context).width;

        return Column(
          children: [
            InkWell(
              onTap: () => _selectSection(
                width: width,
                context: context,
                sectionIndex: sectionIndex,
                absenceCubit: absenceCubit,
                sectionsCubit: sectionsCubit,
              ),
              child: Container(
                color: sectionsCubit.isCurrentSection(sectionIndex)
                    ? const Color(0XFF2a3942)
                    : Colors.transparent,
                child: Row(
                  children: [
                    PopupMenuButton<int>(
                      iconSize: 17,
                      position: PopupMenuPosition.under,
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(value: 0, child: Text('تعديل')),
                          const PopupMenuItem(value: 1, child: Text('حذف')),
                        ];
                      },
                      onSelected: (value) {
                        if (value == 0) {
                          _editSection(
                            context: context,
                            cubit: sectionsCubit,
                            index: sectionIndex,
                          );
                        } else if (value == 1) {
                          _deleteSection(
                            context: context,
                            sectionCubit: sectionsCubit,
                            absenceCubit: absenceCubit,
                            index: sectionIndex,
                          );
                        }
                      },
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.centerRight,
                        child: Text(
                          sectionsCubit.sections[sectionIndex].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              color: Colors.grey,
              width: double.infinity,
              height: 0.5,
            ),
          ],
        );
      },
    );
  }

  _selectSection({
    required int sectionIndex,
    required double width,
    required BuildContext context,
    required AbsenceCubit absenceCubit,
    required SectionsCubit sectionsCubit,
  }) {
    sectionsCubit.selectSection(sectionIndex: sectionIndex);
    absenceCubit.selectSection(sectionIndex: sectionIndex);
    if (width < AdaptiveLayout.mobileBreakPoint) {
      _navigateToAbsenceView(context);
    }
  }

  _editSection({
    required BuildContext context,
    required SectionsCubit cubit,
    required int index,
  }) {
    String sectionTitle = '';
    showAlertDialog(
      context,
      content: SectionTextForm(
        hintText: 'أدخل اسم المجموعه الجديد',
        onChanged: (value) {
          sectionTitle = value;
        },
      ),
      onAccept: () {
        if (sectionTitle.isNotEmpty) {
          cubit.editSection(
            index: index,
            title: sectionTitle,
          );
        }
      },
    );
  }

  _deleteSection({
    required BuildContext context,
    required SectionsCubit sectionCubit,
    required AbsenceCubit absenceCubit,
    required int index,
  }) {
    showAlertDialog(
      context,
      content: const Text('هل تريد حذف هذه المجموعه بالفعل ؟'),
      acceptTitle: 'نعم',
      denyTitle: 'لا',
      onAccept: () {
        sectionCubit.deleteSection(index);
        absenceCubit.initial();
      },
    );
  }

  _navigateToAbsenceView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AbsenceScheduleView(),
      ),
    );
  }
}
