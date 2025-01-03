import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import '../Models/Master.dart';
import '../Models/subject.dart';
import '../services/appwrite_service.dart';

class selectSubjectesMaster extends StatefulWidget {
  const selectSubjectesMaster({super.key});

  @override
  State<selectSubjectesMaster> createState() => _selectSubjectesState();
}

class _selectSubjectesState extends State<selectSubjectesMaster> {
  final Map<Subject, bool> selectedCourses = {};
  List<Subject> listSubjects = [];

  @override
  void initState() {
    super.initState();

    // Schedule the callback after the first frame.
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _updateList();
    });

    setState(() {});
  }

  // The function to update the list
  Future<void> _updateList() async {
    listSubjects = await AppwriteService().getSubject();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Master master = ModalRoute.of(context)!.settings.arguments as Master;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 36, 132, 83),
          title: Text(
            ' مرحبا أ.' + master.get_name(),
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
              children: listSubjects.map((course) {
                return CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: Color.fromARGB(255, 36, 132, 83),
                  title: Text(course.get_name()),
                  // subtitle: Text(course.get_name_master().get_name()),
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
              onPressed: () async {
                try {
                  List<Subject> chosenCourses = selectedCourses.entries
                      .where((entry) => entry.value)
                      .map((entry) => entry.key)
                      .toList();
                  for (int i = 0; i < chosenCourses.length; i++) {
                    Subject course = chosenCourses[i];
                    course.set_name_master(master);
                    await AppwriteService().updateSubject(course);
                  }
                  master.add_subject(chosenCourses);
                  await AppwriteService().updateMaster(master);
                  Navigator.popAndPushNamed(context, '/Master-Screen',
                      arguments: master);
                } on AppwriteException catch (e) {
                  if (e.code == 404) {
                    Navigator.popAndPushNamed(context, '/Master-Screen',
                        arguments: master);
                  } else {
                    SnackBar s =
                        SnackBar(content: Text("حدث خطأ لم يتم تسجيل المواد"));
                    ScaffoldMessenger.of(context).showSnackBar(s);
                  }
                }
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
