import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

import 'package:ico_open/config/config.dart';
import 'package:ico_open/personal_info/page.dart';
import 'package:ico_open/personal_info/api.dart' as api;

enum OfficeAddress { registered, currentAddress, others }

class PersonalInformationOccupation extends StatefulWidget {
  const PersonalInformationOccupation({super.key});

  @override
  State<PersonalInformationOccupation> createState() =>
      _PersonalInformationOccupationState();
}

class _PersonalInformationOccupationState
    extends State<PersonalInformationOccupation> {
  OfficeAddress? _currentAddress = OfficeAddress.registered;
  final TextEditingController _homeNumber = TextEditingController();
  final TextEditingController _companyName = TextEditingController();

final _zipCode = TextEditingController();
  final _country = TextEditingController();
  List<String> provinceItems = provinces;
  final thProvinceLable = 'จังหวัด';
  final thAmphureLable = 'เขตอำเภอ';
  List<String> amphureItems = [];
  final thTambonLable = 'แขวงตำบล';
  List<String> tambonItems = [];

  bool _loadingAmphure = true;
  bool _loadingTambon = true;
  bool _loadingZipcode = true;

  String? thProvinceValue;
  String? thAmphureValue;
  String? thTambonValue;
  String? zipcode;

  void getCurrentAmphure() async {
    amphureItems = await api.getAmphure(thProvinceValue);
    setState(() {
      _loadingAmphure = false;
      thAmphureValue = amphureItems.first;
    });
    print('amphure items: $amphureItems');
  }

  void getCurrentTambon() async {
    tambonItems = await api.getTambon(thAmphureValue);
    setState(() {
      _loadingTambon = false;
      thTambonValue = tambonItems.first;
    });
    print('tambon items: $tambonItems');
  }

  void getCurrentZipcode() async {
    final zipname = thProvinceValue! + thAmphureValue! + thTambonValue!;
    zipcode = await api.getZipCode(zipname);
    _zipCode.text = zipcode!;
    setState(() {
      _loadingZipcode = false;
    });
  }

  // bool _loadingProvince = true;
  void getCurrentProvince() async {
    provinces = await api.getProvince();
    _country.text = 'ไทย';
    log('current provinces: $provinces');
    setState(() {
      provinceItems = provinces;
      // thProvinceValue = provinceItems.first;
    });
  }

  Widget dropdownTHProvinceButtonBuilder(
      {required String? value,
      required String label,
      required List<String> items,
      required Function(String?) onChanged}) {
    return DropdownButtonFormField(
      value: value,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(text: label, children: const [
            TextSpan(
              text: '*',
              style: TextStyle(
                color: Colors.red,
              ),
            )
          ]),
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
    return Container(
      width: MediaQuery.of(context).size.width * displayWidth,
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
          color: Colors.lightBlue.withOpacity(
            .3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                text: const TextSpan(
                  text: 'อาชีพปัจจุบันแลหะแหล่งที่มาของเงินลงทุน',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
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
            ],
          ),
          const HighSpace(height: 20),
          const Row(
            children: [
              Expanded(
                flex: 1,
                child: IncomeDropdownButton(),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: OccupationDropdownButton(),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _companyName,
                  decoration: InputDecoration(
                    label: RichText(
                      text: const TextSpan(
                        text: 'ชื่อสถานที่ทำงาน',
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r'[a-zA-Z0-9ก-๛]',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const HighSpace(height: 20),
          Row(
            children: [
              const Icon(Icons.location_on),
              const Text(
                'ที่ตั้งที่ทำงาน',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child: ListTile(
                  title: const Text('ที่อยู่ตามบัตรประชาชน'),
                  leading: Radio<OfficeAddress>(
                    value: OfficeAddress.registered,
                    groupValue: _currentAddress,
                    onChanged: (OfficeAddress? value) {
                      setState(() {
                        _currentAddress = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ListTile(
                  title: const Text('ที่อยู่ปัจจุบัน'),
                  leading: Radio<OfficeAddress>(
                    value: OfficeAddress.currentAddress,
                    groupValue: _currentAddress,
                    onChanged: (OfficeAddress? value) {
                      setState(() {
                        _currentAddress = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ListTile(
                  title: const Text('ที่อยู่อื่น (โปรดระบุ)'),
                  leading: Radio<OfficeAddress>(
                    value: OfficeAddress.others,
                    groupValue: _currentAddress,
                    onChanged: (OfficeAddress? value) {
                      setState(() {
                        _currentAddress = value;
                        getCurrentProvince();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          (_currentAddress == OfficeAddress.others)
              ? Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _homeNumber,
                            decoration: InputDecoration(
                                label: RichText(
                              text: const TextSpan(
                                text: 'เลขที่',
                                children: [
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: _homeNumber,
                            decoration: InputDecoration(
                                label: RichText(
                              text: const TextSpan(
                                text: 'หมู่ที่',
                              ),
                            ),),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _homeNumber,
                            decoration: InputDecoration(
                                label: RichText(
                              text: const TextSpan(
                                text: 'หมู่บ้าน',
                              ),
                            ),),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _homeNumber,
                            decoration: InputDecoration(
                                label: RichText(
                              text: const TextSpan(
                                text: 'ซอย',
                              ),
                            ),),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _homeNumber,
                            decoration: InputDecoration(
                                label: RichText(
                              text: const TextSpan(
                                text: 'ถนน',
                              ),
                            ),),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: dropdownTHProvinceButtonBuilder(
                            value: thTambonValue,
                            label: thTambonLable,
                            items: tambonItems,
                            onChanged: (String? value) {
                              setState(() {
                                thTambonValue = value;
                                getCurrentZipcode();
                              });
                              if (_loadingZipcode) {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: dropdownTHProvinceButtonBuilder(
                            value: thAmphureValue,
                            label: thAmphureLable,
                            items: amphureItems,
                            onChanged: (String? value) {
                              setState(() {
                                thAmphureValue = value;
                                getCurrentTambon();
                              });
                              if (_loadingTambon) {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: dropdownTHProvinceButtonBuilder(
                            value: thProvinceValue,
                            label: thProvinceLable,
                            items: provinceItems,
                            onChanged: (String? value) {
                              setState(
                                () {
                                  thProvinceValue = value;
                                  getCurrentAmphure();
                                  // thAmphureValue = amphureItems.first;
                                },
                              );
                              if (_loadingAmphure) {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _zipCode,
                            decoration: InputDecoration(
                              label: RichText(
                                text: const TextSpan(
                                    text: 'รหัสไปรษณีย์',
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _country,
                            decoration: InputDecoration(
                              label: RichText(
                                text: const TextSpan(text: 'ประเทศ', children: [
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : const Column()
        ],
      ),
    );
  }
}

class IncomeDropdownButton extends StatefulWidget {
  const IncomeDropdownButton({super.key});

  @override
  State<IncomeDropdownButton> createState() => _IncomeDropdownButtonState();
}

const List<String> incomeLists = <String>[
  'รายรับประจำ',
  'รายรับพิเศษ',
  'ค่าเช่า / ขายของ',
  'เงินโบนัส / เงินรางวัล',
  'กำไรจากการลงทุน',
  'เงินออม',
];

class _IncomeDropdownButtonState extends State<IncomeDropdownButton> {
  String incomeDropdownValue = incomeLists.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        label: RichText(
          text: const TextSpan(
            text: 'แหล่งที่มาของรายได้',
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
      iconSize: 0,
      alignment: Alignment.centerLeft,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(() {
          incomeDropdownValue = value!;
        });
      },
      items: incomeLists.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class OccupationDropdownButton extends StatefulWidget {
  const OccupationDropdownButton({super.key});

  @override
  State<OccupationDropdownButton> createState() =>
      _OccupationDropdownButtonState();
}

const List<String> occupationLists = <String>[
  'ลูกจ้าง/พนักงานเอกชน',
  'ข้าราชการ/พนักงานรัฐวิสาหกิจ',
  'เจ้าของกิจการ/ค้าขาย',
  'พ่อบ้าน/แม่บ้าน',
  'เกษียณ',
  'นักลงทุน',
  'นักศึกษา',
  'ค้าอัญมณี',
  'ค้าของเก่า',
  'แลกเปลี่ยนเงินตรา',
  'บริการโอนเงิน',
  'คาสิโน/บ่อน',
  'ธุรกิจสถานบริการ',
  'ค้าอาวุธ',
  'นายหน้าจัดหางาน',
  'ธุรกิจนำเที่ยว',
];

class _OccupationDropdownButtonState extends State<OccupationDropdownButton> {
  String occupationDropdownValue = occupationLists.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        label: RichText(
          text: const TextSpan(
            text: 'อาชีพปัจจุบัน',
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
      onChanged: (String? value) {
        setState(() {
          occupationDropdownValue = value!;
        });
      },
      items: occupationLists.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
