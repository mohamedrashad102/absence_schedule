import 'package:absence_schedule/common/constants/keys.dart';
import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 1)
class Student {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late final List<bool?> daysStates;

  Student({
    String? name,
    List<bool?>? daysStates,
  }) {
    this.name = name ?? '';
    this.daysStates = daysStates ?? List.generate(1, (index) => null);
  }

  factory Student.fromJson(Map<String, dynamic> data) {
    return Student(
      name: data[Keys.name],
      daysStates: data[Keys.daysStates].cast<bool?>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Keys.name: name,
      Keys.daysStates: daysStates,
    };
  }

  void nextDayState(int dayIndex) {
    if (dayIndex < 0 || dayIndex >= daysStates.length) return;
    if (daysStates.elementAt(dayIndex) == null) {
      daysStates[dayIndex] = true;
    } else if (daysStates.elementAt(dayIndex) == true) {
      daysStates[dayIndex] = false;
    } else if (daysStates.elementAt(dayIndex) == false) {
      daysStates[dayIndex] = null;
    }
  }

  void changeName(String name) {
    this.name = name;
  }

  void addNewDay() {
    daysStates.add(null);
  }
}
