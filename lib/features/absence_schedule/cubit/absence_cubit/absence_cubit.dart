import 'package:absence_schedule/common/models/section.dart';
import 'package:absence_schedule/features/absence_schedule/data/sections_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'absence_state.dart';

class AbsenceCubit extends Cubit<AbsenceState> {
  AbsenceCubit() : super(AbsenceInitial());

  static AbsenceCubit of(BuildContext context) => BlocProvider.of(context);
  late Section section;
  late final List<TextEditingController> controllers = [];
  late int sectionIndex;

  initial() {
    emit(AbsenceInitial());
  }

  selectSection({required int sectionIndex}) {
    emit(AbsenceLoadingState());
    // save current section index and section
    this.sectionIndex = sectionIndex;
    section = SectionsBox.getSection(index: sectionIndex);

    // clear old controllers and add new controllers
    controllers.clear();
    controllers.addAll(
      List.generate(
        section.students.length,
        (index) => TextEditingController(
          text: section.students[index].name,
        ),
      ),
    );
    emit(AbsenceSuccessState());
  }

  changeStudentName({
    required String name,
    required int studentIndex,
  }) {
    emit(AbsenceLoadingState());
    section.students[studentIndex].changeName(name);
    controllers[studentIndex].text = name;
    _fixedDays();
    _fixedStudents();
    SectionsBox.editSection(
      index: sectionIndex,
      section: section,
    );
    emit(AbsenceSuccessState());
  }

  changeDayState({
    required int studentIndex,
    required int dayIndex,
  }) {
    emit(AbsenceLoadingState());
    section.students[studentIndex].nextDayState(dayIndex);
    _fixedDays();
    _fixedStudents();
    SectionsBox.editSection(
      index: sectionIndex,
      section: section,
    );
    emit(AbsenceSuccessState());
  }

  _fixedDays() {
    for (int day = 0; day < section.students.first.daysStates.length; day++) {
      bool isEmpty = true;
      for (var student in section.students) {
        if (student.daysStates[day] != null) {
          isEmpty = false;
          break;
        }
      }
      if (isEmpty) {
        if (day != section.students.first.daysStates.length - 1) {
          for (int i = 0; i < section.students.length; i++) {
            section.students[i].daysStates.removeAt(day);
          }
        }
      } else {
        if (day == section.students.first.daysStates.length - 1) {
          for (int i = 0; i < section.students.length; i++) {
            section.students[i].addNewDay();
          }
        }
      }
    }
  }

  _fixedStudents() {
    for (int i = 0; i < section.students.length; i++) {
      bool isEmpty = section.students[i].name.isEmpty;
      for (var day in section.students[i].daysStates) {
        if (day != null) {
          isEmpty = false;
          break;
        }
      }
      if (isEmpty) {
        if (i != section.students.length - 1) {
          section.students.removeAt(i);
          controllers.removeAt(i);
        }
      } else {
        if (i == section.students.length - 1) {
          section.addNewStudent(
              initialDays: section.students.first.daysStates.length);
          controllers.add(TextEditingController());
        }
      }
    }
  }
}
