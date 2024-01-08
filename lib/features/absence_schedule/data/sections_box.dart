import 'package:absence_schedule/common/constants/keys.dart';
import 'package:absence_schedule/common/models/section.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class SectionsBox {
  static late Box<Section> sectionsBox;

  static Future<void> openSectionsBox() async {
    sectionsBox = await Hive.openBox<Section>(Keys.sections);
  }

  // sections
  static void addSection({required Section section}) async {
    await sectionsBox.add(section);
  }

  static void editSection({
    required Section section,
    required int index,
  }) async {
    await sectionsBox.putAt(index, section);
  }

  static void editSectionTitle({
    required String title,
    required int index,
  }) {
    sectionsBox.values.toList()[index].changeTitle(title);
  }

  static void deleteSection({required int index}) async {
    await sectionsBox.deleteAt(index);
  }

  static Section getSection({required int index}) {
    Section section = sectionsBox.getAt(index)!;
    return section;
  }

  static List<Section> getAllSections() {
    List<Section> sections = sectionsBox.values.toList();
    return sections;
  }

  // students
  static void addStudent({
    required int sectionIndex,
    required int initialDays,
  }) {
    // way one
    sectionsBox.values
        .toList()[sectionIndex]
        .addNewStudent(initialDays: initialDays);

    // way two
    // Section currentSection = getSection(index: sectionIndex);
    // currentSection.addNewStudent(initialDays: initialDays);
    // editSection(section: currentSection, index: sectionIndex);
  }

  static void changeStudentName({
    required int sectionIndex,
    required int studentIndex,
    required String name,
  }) {
    sectionsBox.values
        .toList()[sectionIndex]
        .students[studentIndex]
        .changeName(name);
  }

  static void nextDayState({
    required int sectionIndex,
    required int studentIndex,
    required int dayIndex,
  }) {
    sectionsBox.values
        .toList()[sectionIndex]
        .students[studentIndex]
        .nextDayState(dayIndex);
  }

  static void deleteStudent({
    required int sectionIndex,
    required int studentIndex,
  }) {
    sectionsBox.values.toList()[sectionIndex].students.removeAt(studentIndex);
  }
}
