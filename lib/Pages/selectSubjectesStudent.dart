import 'package:flutter/material.dart';

import 'package:it/Models/lecture.dart';

class selectSubjectesStudent extends StatefulWidget {
  const selectSubjectesStudent({super.key});

  @override
  State<selectSubjectesStudent> createState() => _selectSubjectesState();
}

class _selectSubjectesState extends State<selectSubjectesStudent> {
  final Map<subject, bool> selectedCourses = {};
  @override
  Widget build(BuildContext context) {
    final Student user = ModalRoute.of(context)!.settings.arguments as Student;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 36, 132, 83),
          title: Text(
            'مرحبا ' + user.get_name(),
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20),
            child: Text(
              textAlign: TextAlign.center,
              'الرجاء تحديد المواد المسجل فيها في هذا الفصل',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 36, 132, 83),
            endIndent: 20,
            indent: 20,
            thickness: 2,
          ),
          Expanded(
            child: ListView(
              children: Subjects.map((course) {
                return CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: Color.fromARGB(255, 36, 132, 83),
                  title: Text(course.get_name()),
                  subtitle: Text(course.get_name_master().get_name()),
                  value: selectedCourses[course] ?? false,
                  onChanged: (bool? value) {
                    setState(() {
                      selectedCourses[course] = value ?? false;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 36, 132, 83),
            endIndent: 20,
            indent: 20,
            thickness: 3,
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 36, 132, 83),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextButton(
              onPressed: () {
                List<subject> chosenCourses = selectedCourses.entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .toList();
                user.add_subject(chosenCourses);
                Navigator.popAndPushNamed(context, '/Student-Screen',
                    arguments: user);
              },
              child: Text(
                'التالي',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]));
  }
}

// class selectSubjectesStudent extends StatefulWidget {
//   const selectSubjectesStudent({super.key});

//   @override
//   State<selectSubjectesStudent> createState() => _selectSubjectesState();
// }

// class _selectSubjectesState extends State<selectSubjectesStudent> {
 
//   final Map<String, bool> selectedCourses = {};
//   @override
//   void initState() {
//     super.initState();
//     for (var course in Subjects) {
//       selectedCourses[course.get_code()] = false;
//     }
//   }

//   Widget build(BuildContext context) {
//      final Student user = ModalRoute.of(context)!.settings.arguments as Student;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("حدد المواد المسجل فيها هذا الفصل"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               children: Subjects.map((course) {
//                 return CheckboxListTile(
//                   title: Column(
//                     children: [
//                       Text(course.get_code().toString() + '   :   رمز المقرر'),
//                       Text("اسم المقرر   :   " + course.get_name()),
//                       Text("اسم الاستاذ   :   " +
//                           course.get_name_master().get_name()),
//                       Text(course.get_numUnites().toString() +
//                           "   :   عدد الوحدات"),
//                     ],
//                   ),
//                   value: selectedCourses[course.get_code()],
//                   onChanged: (bool? value) {
//                     setState(() {
//                       selectedCourses[course.get_code()] = value!;
//                       if (value == true) {
//                         // user.add_subject(selectedCourses)
//                       }
//                     });
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//           Container(
//             color: const Color.fromARGB(255, 9, 82, 32),
//             child: TextButton(
//                 onPressed: () {
//                   setState(() {});
//                 },
//                 child: Text(
//                   'اضافة',
//                   style: TextStyle(color: Colors.white),
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }


