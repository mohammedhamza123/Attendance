import 'package:flutter/material.dart';

import 'package:it/Models/lecture.dart';

import '../Models/Master.dart';
import '../Models/subject.dart';

class selectSubjectesMaster extends StatefulWidget {
  const selectSubjectesMaster({super.key});

  @override
  State<selectSubjectesMaster> createState() => _selectSubjectesState();
}

class _selectSubjectesState extends State<selectSubjectesMaster> {
  final Map<Subject, bool> selectedCourses = {};
  @override
  Widget build(BuildContext context) {
    final Master master = ModalRoute.of(context)!.settings.arguments as Master;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 36, 132, 83),
          title: Text(
            'مرحبا ' + master.get_name(),
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20),
            child: Text(
              textAlign: TextAlign.center,
              'الرجاء تحديد المواد المكلف بتدريسها  في هذا الفصل',
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
              children: subjects.map((course) {
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
                List<Subject> chosenCourses = selectedCourses.entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .toList();
                master.add_subject(chosenCourses);
                Navigator.popAndPushNamed(context, '/Master-Screen',
                    arguments: master);
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
