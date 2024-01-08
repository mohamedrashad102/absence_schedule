import 'dart:convert';

import 'package:absence_schedule/common/constants/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/models/section.dart';

class LocalData {
  static late final SharedPreferences _pref;

  static init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static void setSections(List<Section> sections) {
    try {
      String json = jsonEncode(sections);
      _pref.setString(Keys.sections, json);
    } on Exception catch (e) {
      print('error on setSections: ${e.toString()}');
    }
  }

  static List<Section> getSections() {
    String? json = _pref.getString(Keys.sections);
    if (json == null) return [];
    List<dynamic> data = jsonDecode(json);
    List<Section> sections =
        data.map((section) => Section.fromJson(section)).toList();
    return sections;
  }
}
