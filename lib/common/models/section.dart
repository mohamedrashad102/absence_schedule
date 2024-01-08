import 'package:absence_schedule/common/constants/keys.dart';
import 'package:absence_schedule/common/models/student.dart';
import 'package:hive/hive.dart';

part 'section.g.dart';

@HiveType(typeId: 0)
class Section {
  @HiveField(0)
  String title;
  @HiveField(1)
  late final List<Student> students;

  Section({
    required this.title,
    List<Student>? students,
  }) : students = students ?? List.generate(1, (_) => Student());

  factory Section.fromJson(Map<String, dynamic> data) {
    final List<dynamic>? studentList = data[Keys.students];

    return Section(
      title: data[Keys.title],
      students: studentList != null
          ? List<Student>.from(
              studentList.map((studentData) => Student.fromJson(studentData)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Keys.title: title,
      Keys.students: students.map((student) => student.toJson()).toList(),
    };
  }

  changeTitle(String title) {
    this.title = title;
  }

  addNewStudent({required int initialDays}) {
    students.add(Student(
      daysStates: List.generate(initialDays, (index) => null),
    ));
  }
}
