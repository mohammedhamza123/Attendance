// كلاسس الطالب
import 'package:it/Models/Master.dart';
import 'package:it/Models/subject.dart';

class Student {
  String id;
  int _univNum;
  int maxUnite = 18;
  int minUnite = 14;
  String _name;
  String _password;
  List<Subject> _subjectes = [];

  Student(this.id, this._univNum, this._name, this._password);

  int get_unvNum() {
    return _univNum;
  }

  void set_unvNum(int n) {
    _univNum = n;
  }

  String get_pass() {
    return _password;
  }

  String get_name() {
    return _name;
  }

  int get_count_sub() {
    return _subjectes.length;
  }

  void add_subject(List<Subject> s) {
    _subjectes = s;
  }

  List<Subject> get_subject() {
    return _subjectes;
  }

  Subject get_subject_where_id(String code) {
    for (var i = 0; i < _subjectes.length; i++) {
      if (_subjectes[i].get_code() == code) {
        return _subjectes[i];
      }
    }
    return Subject("", "", "as", 0, Master(5, '', '', ''));
  }

  factory Student.fromMap(data) {
    return Student(data.$id, data.data["univNum"], data.data["name"],
        data.data["password"]);
  }

  factory Student.fromMapForLecture(data) {
    return Student(
        data["\$id"], data["univNum"], data["name"], data["password"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "univNum": get_unvNum(),
      "name": _name,
      "password": _password,
    };
  }
}
