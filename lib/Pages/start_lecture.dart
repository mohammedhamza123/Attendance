import 'dart:async';

import 'package:flutter/material.dart';
import 'package:it/Models/lecture.dart';

import '../services/appwrite_service.dart';

class StartLecture extends StatefulWidget {
  const StartLecture({super.key});

  @override
  State<StartLecture> createState() => _StartLectureState();
}

class _StartLectureState extends State<StartLecture> {
  Lecture? lec;
  String acc = "master";
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {});
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      lec = args["lec"];
      acc = args["acc"];
      setState(() {});
      // await _updateList(lec.id);
      // setState(() {});
    });
    setState(() {});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  // The function to update the list
  // Future<void> _updateList(String id) async {
  //   setState(() {});
  //   lec = await AppwriteService().getLecture(id);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, dynamic) async {
        AppwriteService().deleteLecture(lec!);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 36, 132, 83),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.red,
              )),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: Color.fromARGB(255, 36, 132, 83), width: 2)),
              child: Column(
                children: [
                  Text(
                    'اسم المادة : ' + "${lec?.subjectName}",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'اسم المحاضر : ' + "${lec?.masterName}",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   'رقم المحاضرة : ' + lec.id.toString(),
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'عنوان المحاضرة : ' + "${lec?.title}",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'رقم القاعة : ' + "${lec?.hallNumber}",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'كود تسجيل الحضور : ' + "${lec?.code}",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            acc == "master"
                ? Container(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    decoration:
                        BoxDecoration(color: Color.fromARGB(255, 36, 132, 83)),
                    child: Text(
                      textAlign: TextAlign.center,
                      'اسماء الطلبة الحاضرون',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 10,
            ),
            acc == "master"
                ? Expanded(
                    child: FutureBuilder(
                    future: AppwriteService().getLecture(lec?.id ?? ""),
                    builder: (BuildContext context,
                        AsyncSnapshot<Lecture> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        case ConnectionState.active:
                          return Center(child: CircularProgressIndicator());
                        case ConnectionState.done:
                          Lecture lecture = snapshot.data ?? lec!;
                          return RefreshIndicator(
                            onRefresh: () async {
                              setState(() {});
                            },
                            child: ListView.builder(
                              itemCount: lecture.student.length,
                              itemBuilder: (context, index) => ListTile(
                                title: Text(
                                    "${lecture.student[index].get_name()}"),
                                subtitle: Text(DateTime.now().toString()),
                                trailing: Text(
                                    "${lecture.student.length.toString()}"),
                              ),
                            ),
                          );
                        default:
                          return Text("لا يوجد طلبه حاليا");
                      }
                    },
                  ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
