import 'package:flutter/material.dart';

import '../Models/lecture.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController _nameControllaer = TextEditingController();
  TextEditingController _numControllaer = TextEditingController();
  TextEditingController _passwordControllaer = TextEditingController();
  TextEditingController _password2Controllaer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 36, 132, 83),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              textAlign: TextAlign.center,
              'انشئ الحساب الخاص بك',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: ListView(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _nameControllaer,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.check,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'الاسم كامل',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 40, 88, 54),
                            ),
                          )),
                    ),
                    TextField(
                      controller: _numControllaer,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.check,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'رقم القيد',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 40, 88, 54),
                            ),
                          )),
                    ),
                    TextField(
                      controller: _passwordControllaer,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'كلمة المرور',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 40, 88, 54),
                            ),
                          )),
                    ),
                    TextField(
                      controller: _password2Controllaer,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          label: Text(
                            ' تأكيد كلمة المرور',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 40, 88, 54),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 36, 132, 83),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_nameControllaer.text.isNotEmpty &&
                              _numControllaer.text.isEmpty &&
                              _passwordControllaer.text.isNotEmpty &&
                              _password2Controllaer.text.isNotEmpty) {
                            if (_passwordControllaer.text ==
                                _password2Controllaer.text) {
                              Student S = Student(
                                  mastresList.length,
                                  int.parse(_numControllaer.text),
                                  _nameControllaer.text,
                                  _passwordControllaer.text);
                              studentList.add(S);
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/student', (Route<dynamic> route) => false);
                            }
                          }
                        },
                        child: Text(
                          ' انشاء الحساب',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ],
    ));
  }
}
