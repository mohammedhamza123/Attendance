// كلاس المحاضرة
import 'package:it/Models/Master.dart';
import 'package:it/Models/student.dart';
import 'package:it/Models/subject.dart';

class Lecture {
  String id;
  int code;
  String hallNumber;
  String subjectName;
  String title;
  String masterName;
  List<Student> student = [];
  DateTime lectureDate;

  Lecture(this.id, this.code, this.hallNumber, this.title, this.masterName,
      this.subjectName, this.lectureDate, this.student);

  factory Lecture.fromMap(Map<String, dynamic> e) {
    final Map<String, dynamic> data = e["data"];
    return Lecture(
        e["\$id"],
        data["code_lectuer"],
        data["hallNumber"],
        data["titel"],
        data["name_master"],
        data['subject']["name"] ?? "",
        // data["students"],
        // data["lecture_date"],
        DateTime.now(),
        []);
  }

  factory Lecture.fromMapWithStudents(
      Map<String, dynamic> e, List<Student> students) {
    final Map<String, dynamic> data = e["data"];
    return Lecture(
        e["\$id"],
        data["code_lectuer"],
        data["hallNumber"],
        data["titel"],
        data["name_master"],
        data['subject']["name"] ?? "",
        // data["students"],
        // data["lecture_date"],
        DateTime.now(),
        students);
  }
}

List<Student> studentList = [];
// List<Student> studentList = [
//   Student(0, 17, 'محمد شنب', '123'),
// ];
List<Master> masterList = [];
// List<Master> masterList = [
//   Master(0, 10, 'فاطمة الطاهر', '123'),
//   Master(0, 11, 'فاطمة الطاهر', '123'),
// ];
List<Subject> selectedSubjects = [];
List<Subject> subjects = [];
// List<Subject> Subjects = [
//   Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
//   Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
//   Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
//   Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
//   Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
// ];
