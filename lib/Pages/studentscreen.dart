import 'dart:core';

import 'package:flutter/material.dart';
import 'package:it/services/appwrite_service.dart';

import '../Models/lecture.dart';
import '../Models/student.dart';

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  TextEditingController codeController = TextEditingController();

  bool isAttendanceSuccessful = false;

  @override
  Widget build(BuildContext context) {
    final Student user = ModalRoute.of(context)!.settings.arguments as Student;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/');
              },
              icon: Icon(Icons.logout_rounded),
              color: Colors.black,
            )
          ],
          backgroundColor: Color.fromARGB(255, 36, 132, 83),
          title: Text(
            user.get_name(),
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                text: 'المحاضرات الحالية',
              ),
              Tab(
                text: 'تعديل المواد المسجلة',
              ),
              // Tab(),
            ],
          ),
        ),
        body: TabBarView(children: [
          Column(
            children: [
              FutureBuilder(
                future: AppwriteService().getLectureDocs(user.get_subject()),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.data != null) {
                    final data = snapshot.data!;
                    return Flexible(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    // color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 36, 132, 83),
                                      width: 2.0,
                                    )),
                                child: ListTile(
                                  title: Text(
                                      "${data[index].data["titel"]}:${data[index].data["subject"]["name"]}"),
                                  subtitle: Text(
                                      "${data[index].data["name_master"]}:${data[index].data["hallNumber"]}"),
                                  trailing: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  "تسجيل الحضور",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'هل تريد تسجيل الحضور \n(${user.get_subject_where_id(data[index].data["subject"]["code"]).get_name()})\n',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18),
                                                    ),
                                                    TextField(
                                                      controller:
                                                          codeController,
                                                    )
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        'الغاء',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18),
                                                      )),
                                                  TextButton(
                                                      onPressed: () {
                                                        if (codeController.text
                                                                .trim()
                                                                .toString() ==
                                                            data[index]
                                                                .data[
                                                                    "code_lectuer"]
                                                                .toString()) {
                                                          final Lecture lec =
                                                              Lecture.fromMap(
                                                                  data[index]
                                                                      .toMap());
                                                          if (data[index].data[
                                                                  "students"] !=
                                                              null) {
                                                            data[index].data["students"].map((e){
                                                              lec.student.add(Student.fromMap(e));
                                                            });
                                                          }
                                                          lec.student.add(user);
                                                          AppwriteService()
                                                              .updateLecture(
                                                                  lec);
                                                          Navigator
                                                              .pushReplacementNamed(
                                                                  context,
                                                                  '/Start-Lecture',
                                                                  arguments: {
                                                                "acc":
                                                                    "student",
                                                                "lec": lec
                                                              });
                                                        } else {
                                                          var snackBar =
                                                              SnackBar(
                                                            content: Text(
                                                              // 'لم يتم تسجيل حضورك ',
                                                              "${data[index].data["code_lectuer"]}",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Arial',
                                                                  fontSize: 16),
                                                            ),
                                                            backgroundColor:
                                                                Colors.red,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                          );

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      },
                                                      child: Text(
                                                        "تأكيد",
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 18),
                                                      )),
                                                ],
                                              );
                                            });
                                      },
                                      icon: Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      )),
                                ),
                              ),
                            );
                            // return LectureListItem(
                            //   hallNumber: data[index].data["hallNumber"],
                            //   lectureNumber: "",
                            //   lectureTitle: data[index].data["titel"],
                            //   subjectTeacher: data[index].data["name_master"],
                            // );
                          }),
                    );
                  } else if (snapshot.data == []) {
                    return Center(
                      child: Text("لا يوجد محاضارات في الوقت الحالي"),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                child: Text("المواد المسجلة"),
              ),
              Divider(
                thickness: 3.0,
                indent: 20,
                endIndent: 20,
                color: Color.fromARGB(255, 36, 132, 83),
              ),
              Expanded(
                  flex: 1,
                  child: ListView.builder(
                      itemCount: user.get_subject().length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20.0, 10, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 36, 132, 83),
                                    width: 2.0,
                                  )),
                              child: ListTile(
                                leading: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.more_horiz),
                                  color: Colors.black,
                                ),
                                title:
                                    Text(user.get_subject()[index].get_name()),
                                subtitle: Text(user
                                    .get_subject()[index]
                                    .get_name_master()
                                    .get_name()),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                "تأكيد الحذف",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              content: Text(
                                                textAlign: TextAlign.center,
                                                'هل انت متأكد من حذف مادة \n(${user.get_subject()[index].get_name()})\nالرجاء عدم حذف اي مادة من موادك المسجل فيها في التطبيق الا بعد حذها من منظومة الكلية ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'الغاء',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      user.get_subject().remove(
                                                          user.get_subject()[
                                                              index]);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "حذف",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 18),
                                                    )),
                                              ],
                                            );
                                          });
                                    });
                                  },
                                  icon: Icon(Icons.delete_forever_rounded),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ))),
              Divider(
                thickness: 3.0,
                indent: 20,
                endIndent: 20,
                color: Color.fromARGB(255, 36, 132, 83),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 9, 82, 32),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, "/Select-Subjectes-Student",
                            arguments: user);
                      },
                      child: Text(
                        "اضافة مادة جديدة",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
