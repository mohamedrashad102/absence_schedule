import 'package:absence_schedule/common/models/section.dart';
import 'package:absence_schedule/features/absence_schedule/data/sections_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sections_state.dart';

class SectionsCubit extends Cubit<SectionsState> {
  SectionsCubit() : super(SectionsInitial());
  static SectionsCubit of(BuildContext context) =>
      BlocProvider.of<SectionsCubit>(context);

  List<Section> sections = [];
  int? currentSectionIndex;

  fetchSections() async {
    emit(SectionsLoading());
    await SectionsBox.openSectionsBox();
    sections.clear(); // clear old sections
    sections.addAll(SectionsBox.getAllSections()); // add new sections
    emit(SectionsSuccessState());
  }

  addSection(Section section) {
    emit(SectionsLoading());
    sections.add(section); // add new section in cubit
    SectionsBox.addSection(section: section); // add new section in hive
    emit(SectionsSuccessState());
  }

  editSection({required String title, required int index}) {
    emit(SectionsLoading());
    if (index < 0 || index >= sections.length) return;
    sections[index].changeTitle(title); // change title in cubit
    SectionsBox.editSectionTitle(
        index: index, title: title); // change title in hive
    emit(SectionsSuccessState());
  }

  deleteSection(int index) {
    emit(SectionsLoading());
    if (index < 0 || index >= sections.length) return; // overflow index
    if (currentSectionIndex == index) {
      currentSectionIndex = null; // unselect current section
    }
    sections.removeAt(index); // remove section form cubit
    SectionsBox.deleteSection(index: index); // remove section from hive
    if (currentSectionIndex == null) {
      emit(SectionsInitial()); // unselect old section
    } else {
      emit(SectionsSuccessState()); // stay selecting old section
    }
  }

  selectSection({required int sectionIndex}) {
    currentSectionIndex = sectionIndex;
    emit(SectionsSuccessState());
  }

  unSelectOldSection() {
    currentSectionIndex = null;
    emit(SectionsSuccessState());
  }

  isCurrentSection(int sectionIndex) {
    if (currentSectionIndex == null) return false;
    if (currentSectionIndex == sectionIndex) return true;
    return false;
  }
}
