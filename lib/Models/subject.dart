//كلاس المواد
import 'package:it/Models/Master.dart';

class Subject {
  String id;
  String _code;
  String _name;
  Master _nameMaster;
  int _numUnites = 0;

  Subject(this.id, this._code, this._name, this._numUnites, this._nameMaster);

  int get_numUnites() {
    return _numUnites;
  }

  String get_code() {
    return _code;
  }

  String get_name() {
    return _name;
  }

  Master get_name_master() {
    return _nameMaster;
  }

  void set_name_master(Master m) {
    _nameMaster = m;
  }

  Map<String, dynamic> toMap() {
    return {
      "\$id": id,
      "code": _code,
    "name": _name,
      "nameMaster": _nameMaster.get_name(),
      "numUnites": _numUnites
    };
  }

  factory Subject.fromMap(Map<String, dynamic> e) {
    return Subject(e["\$id"], e["code"], e["name"], e["numUnites"],
        Master(00, e["nameMaster"], "00", ""));
  }
}
