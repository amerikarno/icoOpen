import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ico_open/config/config.dart';
import 'package:ico_open/personal_info/page.dart';

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
          const Row(
            children: [
              Text(
                'อาชีพปัจจุบันและแหล่งที่มาของเงินลงทุน',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
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
                  decoration: const InputDecoration(
                    label: Text(
                      'ชื่อสถานที่ทำงาน',
                      style: TextStyle(
                        fontSize: 15,
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
                            decoration: const InputDecoration(
                              hintText: 'เลขที่',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: _homeNumber,
                            decoration: const InputDecoration(
                              hintText: 'หมู่ที่',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _homeNumber,
                            decoration: const InputDecoration(
                              hintText: 'หมู่บ้าน',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _homeNumber,
                            decoration: const InputDecoration(
                              hintText: 'ซอย',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _homeNumber,
                            decoration: const InputDecoration(
                              hintText: 'ถนน',
                            ),
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
                          child: TextField(
                            controller: _homeNumber,
                            decoration: const InputDecoration(
                              hintText: 'แขวงตำบล',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _homeNumber,
                            decoration: const InputDecoration(
                              hintText: 'เขตอำเภอ',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _homeNumber,
                            decoration: const InputDecoration(
                              hintText: 'จังหวัด',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _homeNumber,
                            decoration: const InputDecoration(
                              hintText: 'รหัสไปรษณีย์',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _homeNumber,
                            decoration: const InputDecoration(
                              hintText: 'ประเทศ',
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
      decoration: const InputDecoration(
        label: Text(
          'แหล่งที่มาของรายได้',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
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
      decoration: const InputDecoration(
        label: Text(
          'อาชีพปุัจจุบัน',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      iconSize: 0,
      alignment: Alignment.centerLeft,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
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
