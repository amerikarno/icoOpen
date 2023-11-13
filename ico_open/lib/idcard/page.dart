import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ico_open/idcard/api.dart' as api;
import 'package:ico_open/model/idcard.dart';
import 'package:ico_open/model/preinfo.dart' as modelpreinfo;
import 'package:ico_open/preinfo/page.dart';

class IDCardPage extends StatefulWidget {
  // const IDCardPage({super.key});
  IDCardPage({super.key, preinfo});
  modelpreinfo.Preinfo? preinfo;
  @override
  State<IDCardPage> createState() => _IDCardPageState();
}

final TextEditingController _idcard = TextEditingController();
final TextEditingController _lasercodestr = TextEditingController();
final TextEditingController _lasercodenum = TextEditingController();
bool _varidatedIDcard = false;
bool _varidatedLaserStr = false;
bool _varidatedLaserId = false;
bool _varidatedPostInfo = false;
String idCardValue = '';
String laserCodeStrValue = '';
String laserCodeNumValue = '';

// const postIDCard = IDcardModel;

// final TextEditingController _month = TextEditingController();
// final TextEditingController _year = TextEditingController();
enum SingingCharacter { single, married, disvorced }

class _IDCardPageState extends State<IDCardPage> {
  SingingCharacter? _marriageStatus = SingingCharacter.single;

  @override
  void initState() {
    super.initState();
    _createYearLists();
  }

  void _postIDCardInfo(IDcardModel idCard) async {
    final post = await api.postIDCard(idCard);
    setState(() {
      _varidatedPostInfo = post;
    });
    log('varlidate post info: $_varidatedPostInfo');
  }

  void _getIsCorrectIDCard(String idcard) async {
    final isCorrect = await api.getVerifiedIDCard(idcard);
    setState(() {
      _varidatedIDcard = !isCorrect;
    });
  }

  List<String> dateItems = date31Items;
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
      yearItems = list;
      yearValue = yearItems.first;
      dateValue = dateItems.first;
      monthValue = monthItems.first;
    });
  }

  void _verifyDateFeild() {
    final remainder = int.parse(yearValue!) % 4;
    final dateInt = int.parse(dateValue!);
    log('date: $dateInt, month: $monthValue, year: $yearValue', name: 'info');
    switch (monthValue) {
      case 'ก.พ.':
        if (dateInt >= 29) {
          if (remainder == 3) {
            setState(
              () {
                dateValue = '29';
                dateItems = date29Items;
              },
            );
          } else {
            setState(() {
              dateValue = '28';
              dateItems = date28Items;
            });
          }
        } else {
          if (remainder == 3) {
            setState(
              () {
                dateItems = date29Items;
              },
            );
          } else {
            setState(
              () {
                dateItems = date28Items;
              },
            );
          }
        }
      case 'เม.ย.':
      case 'มิ.ย.':
      case 'ก.ย.':
      case 'พ.ย.':
        if (dateInt >= 31) {
          setState(() {
            dateValue = '30';
            dateItems = date30Items;
          });
        } else {
          setState(
            () {
              dateItems = date30Items;
            },
          );
        }
      default:
        dateItems = date31Items;
    }
  }

  String? dateValue;
  final dateLabel = 'วันที่';
  String? monthValue;
  final monthLabel = 'เดือน';
  String? yearValue;
  final yearLabel = 'ปี(พ.ศ.)';
  Widget dropdownButtonBuilder(
      {required String? value,
      required String label,
      required List<String> items,
      required Function(String?) onChanged}) {
    return DropdownButtonFormField(
      value: value,
      decoration: InputDecoration(
        label: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      onChanged: (String? value) {
        setState(() {
          onChanged(value);
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFeild = dropdownButtonBuilder(
      value: dateValue,
      label: dateLabel,
      items: dateItems,
      onChanged: (String? value) {
        setState(() {
          dateValue = value;
          _verifyDateFeild();
        });
      },
    );

    final monthField = dropdownButtonBuilder(
      value: monthValue,
      label: monthLabel,
      items: monthItems,
      onChanged: (String? value) {
        setState(() {
          monthValue = value;
          _verifyDateFeild();
        });
      },
    );

    final yearField = dropdownButtonBuilder(
      value: yearValue,
      label: yearLabel,
      items: yearItems,
      onChanged: (String? value) {
        setState(() {
          yearValue = value;
          _verifyDateFeild();
        });
      },
    );

    // print('preInfo: ${widget.preinfo!.mobile}');

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
              child: Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    width: 300,
                    child: RichText(
                      text: const TextSpan(
                        text: 'วัน/เดือน/ปี เกิด',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 5,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 1,
                    child: dateFeild,
                  ),
                  Expanded(
                    flex: 1,
                    child: monthField,
                  ),
                  Expanded(
                    flex: 1,
                    child: yearField,
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
                  SizedBox(
                    width: 300,
                    child: RichText(
                      text: const TextSpan(
                        text: 'สถานะ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
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
                        groupValue: _marriageStatus,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _marriageStatus = value;
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
                        groupValue: _marriageStatus,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _marriageStatus = value;
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
                        groupValue: _marriageStatus,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _marriageStatus = value;
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
                  SizedBox(
                    width: 300,
                    child: RichText(
                      text: const TextSpan(
                        text: 'หมายเลขบัตรประจำตัวประชาชน',
                        style: TextStyle(fontSize: 20),
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 5,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      maxLength: 13,
                      controller: _idcard,
                      decoration: InputDecoration(
                        labelText: 'ตัวเลข 13หลัก',
                        errorText: _varidatedIDcard
                            ? 'กรุณากรอกหมายเลขบัตรประจำตัวประชาชนให้ถูกต้อง'
                            : null,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                            r'[0-9]',
                          ),
                        ),
                      ],
                      onSubmitted: (value) {
                        if (value.isEmpty) {
                          setState(
                            () {
                              _varidatedIDcard = true;
                            },
                          );
                        } else {
                          _getIsCorrectIDCard(value);
                          if (!_varidatedIDcard) {
                            setState(() {
                              idCardValue = value;
                            });
                          }
                        }
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
                  SizedBox(
                    width: 300,
                    child: RichText(
                      text: const TextSpan(
                        text: 'เลขหลังบัตรประชาชน (Laser Code)',
                        style: TextStyle(fontSize: 20),
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 5,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      maxLength: 2,
                      controller: _lasercodestr,
                      decoration: InputDecoration(
                        labelText: 'ตัวอักษร 2หลักแรก',
                        errorText: _varidatedLaserStr
                            ? 'กรุณากรอกข้อมูลให้ถูกต้องครบถ้วย'
                            : null,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                            r'[a-zA-Z]',
                          ),
                        ),
                      ],
                      onSubmitted: (value) {
                        if (value.isEmpty || value.length != 2) {
                          setState(() {
                            _varidatedLaserStr = true;
                          });
                          log('validate laser state: $_varidatedLaserStr');
                          log('laser state: $_lasercodestr');
                        } else {
                          setState(() {
                            _varidatedLaserStr = false;
                            laserCodeStrValue = value;
                          });
                          log('validate laser state: $_varidatedLaserStr');
                          log('laser state: $_lasercodestr');
                        }
                      },
                    ),
                  ),
                  const Text('-'),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      maxLength: 10,
                      controller: _lasercodenum,
                      decoration: InputDecoration(
                        labelText: 'ตามด้วยตัวเลข 10หลัก',
                        errorText: _varidatedLaserId
                            ? 'กรุณากรอกข้อมูลให้ถูกต้องครบถ้วย'
                            : null,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                            r'[0-9]',
                          ),
                        ),
                      ],
                      onSubmitted: (value) {
                        if (value.isEmpty || value.length != 10) {
                          setState(() {
                            _varidatedLaserId = true;
                          });
                          log('validate laser id: $_varidatedLaserId');
                        } else {
                          setState(() {
                            _varidatedLaserId = false;
                            laserCodeNumValue = value;
                          });
                          log('validate laser id: $_varidatedLaserId');
                        }
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
                        log('laser code:', name: _lasercodestr.toString());
                        if (_idcard.text.toString().isEmpty) {
                          setState(
                            () {
                              _varidatedIDcard = true;
                            },
                          );
                        } else {
                          _getIsCorrectIDCard(_idcard.text.toString());
                          idCardValue = _idcard.text.toString();
                        }
                        if (_lasercodenum.text.isEmpty ||
                            _lasercodenum.text.length != 10) {
                          setState(() {
                            _varidatedLaserId = true;
                          });
                          log('validate laser id: $_varidatedLaserId');
                        } else {
                          setState(() {
                            _varidatedLaserId = false;
                            laserCodeNumValue = _lasercodenum.text;
                          });
                          log('validate laser id: $_varidatedLaserId');
                        }
                        if (_lasercodestr.text.isEmpty ||
                            _lasercodestr.text.length != 2) {
                          setState(() {
                            _varidatedLaserStr = true;
                          });
                          log('validate laser state: $_varidatedLaserStr');
                          log('laser state: $_lasercodestr');
                        } else {
                          setState(() {
                            _varidatedLaserStr = false;
                            laserCodeStrValue = _lasercodestr.text;
                          });
                          log('validate laser state: $_varidatedLaserStr');
                          log('laser state: $_lasercodestr');
                        }

                        final date = '$dateValue $monthValue $yearValue';
                        final laser = '$laserCodeStrValue-$laserCodeNumValue';
                        String marriageStatus = '';
                        if (_marriageStatus == SingingCharacter.single) {
                          marriageStatus = 'โสด';
                        }
                        if (_marriageStatus == SingingCharacter.married) {
                          marriageStatus = 'สมรส';
                        }
                        if (_marriageStatus == SingingCharacter.disvorced) {
                          marriageStatus = 'หย่า';
                        }
                        final postIDCard = IDcardModel(
                          birthdate: date,
                          status: marriageStatus,
                          idcard: idCardValue,
                          laserCode: laser,
                        );
                        _postIDCardInfo(postIDCard);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return const PersonalInformation();
                        //     },
                        //   ),
                        // );
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

const List<String> date31Items = [
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
const List<String> date30Items = [
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
];
const List<String> date29Items = [
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
];
const List<String> date28Items = [
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
];

const List<String> monthItems = [
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

List<String> yearItems = [];
