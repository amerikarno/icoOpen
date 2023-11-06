import 'package:flutter/material.dart';

import 'package:ico_open/config/config.dart';
import 'package:ico_open/personal_info/api.dart';

enum CurrentAddress { registered, others }

class PersonalInformationCurrentAddress extends StatefulWidget {
  const PersonalInformationCurrentAddress({super.key});

  @override
  State<PersonalInformationCurrentAddress> createState() =>
      _PersonalInformationCurrentAddressState();
}

class _PersonalInformationCurrentAddressState
    extends State<PersonalInformationCurrentAddress> {
  CurrentAddress? _currentAddress = CurrentAddress.registered;
  final TextEditingController _homeNumber = TextEditingController();
  // final List<String> provinceItems = [];
  final districtItems = districts;
  final provinceItems = provinces;
  final thLable = 'จังหวัด';

  String? thValue;
  // String? engValue;

  Widget dropdownTHProvinceButtonBuilder(
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
              const Icon(Icons.location_on),
              const Text(
                'ที่อยู่ปัจจุบัน',
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
                flex: 1,
                child: ListTile(
                  title: const Text('ที่อยู่ตามบัตรประชาชน'),
                  leading: Radio<CurrentAddress>(
                    value: CurrentAddress.registered,
                    groupValue: _currentAddress,
                    onChanged: (CurrentAddress? value) {
                      setState(() {
                        _currentAddress = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListTile(
                  title: const Text('ที่อยู่อื่น (โปรดระบุ)'),
                  leading: Radio<CurrentAddress>(
                    value: CurrentAddress.others,
                    groupValue: _currentAddress,
                    onChanged: (CurrentAddress? value) {
                      setState(() {
                        _currentAddress = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          (_currentAddress == CurrentAddress.others)
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
                          child: dropdownTHProvinceButtonBuilder(
                            value: thValue,
                            label: thLable,
                            items: provinceItems,
                            onChanged: (String? value) {
                              setState(
                                () {
                                  getDistrict(value.toString());
                                },
                              );
                            },
                          ),
                          // controller: _homeNumber,
                          // decoration: const InputDecoration(
                          //   hintText: 'จังหวัด',
                          // ),
                          // ),
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
