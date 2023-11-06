import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ico_open/personal_info/page.dart';
import 'package:ico_open/preinfo/page.dart';

class IDCardPage extends StatefulWidget {
  const IDCardPage({super.key});

  @override
  State<IDCardPage> createState() => _IDCardPageState();
}

final TextEditingController _idcard = TextEditingController();
final TextEditingController _lasercodestr = TextEditingController();
final TextEditingController _lasercodenum = TextEditingController();

// final TextEditingController _month = TextEditingController();
// final TextEditingController _year = TextEditingController();
enum SingingCharacter { single, married, disvorced }

class _IDCardPageState extends State<IDCardPage> {
  SingingCharacter? _character = SingingCharacter.single;

  @override
  void initState() {
    super.initState();
    _createYearLists();
  }

  void _createYearLists() {
    int currentYear = DateTime.now().year + 543;
    int start = currentYear - 20;
    int end = currentYear - 100;
    List<String> list = [];
    for (var i = start; i >= end; i--) {
      list.add(i.toString());
    }
    // print(yearLists);
    setState(() {
      yearLists = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.3),
                      spreadRadius: 0.3,
                    )
                  ]),
              child: const Row(
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    'กรอกข้อมูลบัตรประชาชน',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightBlue.withOpacity(0.3),
                      spreadRadius: 0.3,
                    )
                  ]),
              // color: Colors.lightBlue,
              child: const Row(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    width: 300,
                    child: Text(
                      'วัน/เดือน/ปี เกิด',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 1,
                    child: DateDropdownButton(),
                  ),
                  Expanded(
                    flex: 1,
                    child: MonthDropdownButton(),
                  ),
                  Expanded(
                    flex: 1,
                    child: YearDropdownButton(),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightBlue.withOpacity(0.3),
                      spreadRadius: 0.3,
                    )
                  ]),
              child: Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  const SizedBox(
                    width: 300,
                    child: Text(
                      'สถานะ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const Expanded(
                    flex: 5,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      title: const Text('โสด'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.single,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      title: const Text('สมรส'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.married,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      title: const Text('หย่า'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.disvorced,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightBlue.withOpacity(0.3),
                      spreadRadius: 0.3,
                    )
                  ]),
              child: Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  const SizedBox(
                    width: 300,
                    child: Text(
                      'หมายเลขบัตรประจำตัวประชาชน',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const Expanded(
                    flex: 5,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      maxLength: 13,
                      controller: _idcard,
                      decoration: const InputDecoration(
                        labelText: 'ตัวเลข 13หลัก',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                            r'[0-9]',
                          ),
                        ),
                      ],
                      validator: (value) {
                        log('validator:', name: value.toString());
                        if (value!.length == 13 || value.isEmpty) {
                          return 'กรุณาใส่เลขบัตรประชาชนให้ถูกต้อง';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightBlue.withOpacity(0.3),
                      spreadRadius: 0.3,
                    )
                  ]),
              child: Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  const SizedBox(
                    width: 300,
                    child: Text(
                      'เลขหลังบัตรประชาชน (Laser Code)',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const Expanded(
                    flex: 5,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      maxLength: 2,
                      controller: _lasercodestr,
                      decoration: const InputDecoration(
                        labelText: 'ตัวอักษร 2หลักแรก',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                            r'[a-zA-Z]',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text('-'),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      maxLength: 10,
                      controller: _lasercodenum,
                      decoration: const InputDecoration(
                        labelText: 'ตามด้วยตัวเลข 10หลัก',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                            r'[0-9]',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton(
                      // backgroundColor: Colors.orange,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const MyHomePage();
                            },
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.arrow_circle_left,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 30,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      backgroundColor: Colors.orange,
                      onPressed: () {
                        log('laser code:',name: _lasercodestr.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const PersonalInformation();
                            },
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.arrow_circle_right,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DateDropdownButton extends StatefulWidget {
  const DateDropdownButton({super.key});

  @override
  State<DateDropdownButton> createState() => _DateDropdownButtonState();
}

const List<String> dateLists = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31',
];

class _DateDropdownButtonState extends State<DateDropdownButton> {
  String dateDropdownValue = dateLists.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dateDropdownValue,
      hint: const Text('วันที่'),
      icon: const Icon(
        Icons.arrow_downward,
        size: 5,
      ),
      alignment: AlignmentDirectional.center,
      // elevation: 5,
      menuMaxHeight: 200,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(() {
          dateDropdownValue = value!;
        });
      },
      items: dateLists.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class MonthDropdownButton extends StatefulWidget {
  const MonthDropdownButton({super.key});

  @override
  State<MonthDropdownButton> createState() => _MonthDropdownButtonState();
}

const List<String> monthLists = [
  'ม.ค.',
  'ก.พ.',
  'มี.ค.',
  'เม.ย.',
  'พ.ค.',
  'มิ.ย.',
  'ก.ค.',
  'ส.ค.',
  'ก.ย.',
  'ต.ค.',
  'พ.ย.',
  'ธ.ค.',
];

class _MonthDropdownButtonState extends State<MonthDropdownButton> {
  String monthDropdownValue = monthLists.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: monthDropdownValue,
      hint: const Text('เดือน'),
      icon: const Icon(
        Icons.arrow_downward,
        size: 5,
      ),
      alignment: Alignment.center,
      // elevation: 5,
      menuMaxHeight: 200,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(() {
          monthDropdownValue = value!;
        });
      },
      items: monthLists.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class YearDropdownButton extends StatefulWidget {
  const YearDropdownButton({super.key});

  @override
  State<YearDropdownButton> createState() => _YearDropdownButtonState();
}

List<String> yearLists = [];

class _YearDropdownButtonState extends State<YearDropdownButton> {
  String yearDropdownValue = yearLists.first;
  // @override
  // void _createYearLists() {
  //   DateTime now = DateTime.now();
  //   int start = now.year - 20;
  //   int end = now.year - 100;

  //   for (var i = start; i >= end; i--) {
  //     yearLists.add(i.toString());
  //   }
  //   print(yearLists);
  // }

  @override
  Widget build(BuildContext context) {
    // _createYearLists();
    return DropdownButton<String>(
      value: yearDropdownValue,
      hint: const Text('ปี(พ.ศ.)'),
      icon: const Icon(
        Icons.arrow_downward,
        size: 5,
      ),
      alignment: Alignment.center,
      // elevation: 5,
      menuMaxHeight: 200,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(() {
          yearDropdownValue = value!;
        });
      },
      items: yearLists.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
