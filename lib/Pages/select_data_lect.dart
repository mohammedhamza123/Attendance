import 'package:flutter/services.dart';
import 'package:it/Models/lecture.dart';
import 'package:flutter/material.dart';
import 'package:it/services/appwrite_service.dart';
import 'dart:math';

import '../Models/subject.dart';

class carts extends StatefulWidget {
  const carts({
    super.key,
    required this.sub,
  });

  final Subject sub;

  @override
  State<carts> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<carts> {
  int lectureCode = 0;
  final TextEditingController _numLectureController = TextEditingController();
  final TextEditingController _titelLectureController = TextEditingController();

  final List<String> cLass = [
    'L1',
    'L2',
    'L3',
    'L4',
    'L5',
    'L6',
    'L7',
    'L8',
    'L9',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20.0, 10, 0),
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(
            color: Color.fromARGB(255, 36, 132, 83),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.sub.get_name(),
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30.0, 20, 25),
              child: TextField(
                controller: _numLectureController,
                decoration: InputDecoration(
                  label: Text(
                    "رقم المحاضرة",
                    style: TextStyle(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 36, 132, 83),
                  )),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 20, 20),
              child: TextField(
                controller: _titelLectureController,
                decoration: InputDecoration(
                  label: Text(
                    "عنوان المحاضرة",
                    style: TextStyle(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 36, 132, 83),
                  )),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  // القيمة الحالية
                  value: selectedValue,
                  // النص الظاهر إذا لم يتم الاختيار
                  hint: const Text('اختر القاعة'),
                  // أيقونة السهم
                  icon: Icon(Icons.arrow_drop_down),
                  // تصميم الحواف
                  underline: Container(
                    height: 3,
                    color: Color.fromARGB(255, 36, 132, 83),
                  ),
                  // العناصر المتاحة للاختيار
                  items: cLass.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  // عند اختيار عنصر
                  onChanged: (String? newValue) {
                    selectedValue = newValue;
                  },
                ),
                Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 36, 132, 83),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextButton(
                      onPressed: () async {
                        lectureCode = Random().nextInt(900000) + 100000;
                        Lecture lec = Lecture(
                            "",
                            lectureCode,
                            selectedValue ?? "",
                            widget.sub.get_name(),
                            widget.sub.get_name_master().get_name(),
                            widget.sub.id,
                            DateTime.now(), []);
                        lec = await AppwriteService().postLecture(lec);
                        Navigator.pushNamed(
                          context,
                          '/Start-Lecture',
                          arguments: {"acc": "master", "lec": lec},
                        );
                      },
                      child: Text(
                        "بدء",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
