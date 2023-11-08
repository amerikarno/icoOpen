import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:ico_open/config/config.dart';
import 'package:ico_open/personal_info/api.dart' as api;
import 'package:ico_open/personal_info/page.dart';

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
  final _homeNumber = TextEditingController();
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
                        getCurrentProvince();
                      });
                      // if (_loadingProvince) {return CircularProgressIndicator();}
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
