import 'package:absence_schedule/common/models/section.dart';
import 'package:absence_schedule/common/widgets/show_alert_dialog.dart';
import 'package:absence_schedule/features/absence_schedule/cubit/sections_cubit/sections_cubit.dart';
import 'package:absence_schedule/features/absence_schedule/cubit/sections_cubit/sections_state.dart';
import 'package:absence_schedule/features/absence_schedule/views/sections_view/section_item.dart';
import 'package:absence_schedule/features/absence_schedule/views/sections_view/section_text_form.dart';
import 'package:absence_schedule/features/absence_schedule/views/sections_view/sections_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_button.dart';

class SectionsView extends StatelessWidget {
  const SectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionsCubit, SectionsState>(
      builder: (context, state) {
        final sectionCubit = SectionsCubit.of(context);
        return Scaffold(
          appBar: const SectionsAppBar(),
          body: ListView.builder(
            itemBuilder: (context, sectionIndex) => SectionItem(
              sectionIndex: sectionIndex,
            ),
            itemCount: sectionCubit.sections.length,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingAddButton(
            onPressed: () => _addSection(
              context: context,
              sectionCubit: sectionCubit,
            ),
          ),
        );
      },
    );
  }

  _addSection({
    required BuildContext context,
    required SectionsCubit sectionCubit,
  }) {
    String sectionTitle = '';
    showAlertDialog(
      context,
      content: SectionTextForm(
        onChanged: (value) {
          sectionTitle = value;
        },
      ),
      onAccept: () {
        if (sectionTitle.isNotEmpty) {
          sectionCubit.addSection(Section(title: sectionTitle));
        }
      },
    );
  }
}
