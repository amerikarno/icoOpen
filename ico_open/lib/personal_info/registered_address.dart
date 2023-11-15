import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:ico_open/config/config.dart';
import 'package:ico_open/personal_info/api.dart' as api;
import 'package:ico_open/personal_info/page.dart';
import 'package:ico_open/misc/misc.dart' as misc;
import 'package:ico_open/model/model.dart' as model;

class PersonalInformationRegisteredAddress extends StatefulWidget {
  const PersonalInformationRegisteredAddress({
    super.key,
  });

  @override
  State<PersonalInformationRegisteredAddress> createState() =>
      _PersonalInformationRegisteredAddressState();
}

  final homeNumberController = TextEditingController();
  final villageNumberController = TextEditingController();
  final villageNameController = TextEditingController();
  final subStreetNameController = TextEditingController();
  final streetNameController = TextEditingController();
  final zipCodeController = TextEditingController();
  final countryController = TextEditingController();
  final officeNameController = TextEditingController();
  final positionNameController = TextEditingController();

class _PersonalInformationRegisteredAddressState
    extends State<PersonalInformationRegisteredAddress> {

  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController();
  List<String> provinceItems = provinces;
  final thProvinceLable = 'จังหวัด';
  final thAmphureLable = 'เขตอำเภอ';
  List<String> amphureItems = [];
  final thTambonLable = 'แขวงตำบล';
  List<String> tambonItems = [];

  bool _loadingAmphure = true;
  bool _loadingTambon = true;
  bool _loadingZipcode = true;

  // final bool _officeNameCondition = false;
  // final bool _positionNameCondition = false;
  final bool _zipcodeErrorCondition = false;
  final bool _countryErrorCondition = false;
   bool _homeNumberErrorCondition = false;
  final bool _villageNumberErrorCondition = false;
  final bool _villageNameErrorCondition = false;
  final bool _subStreetNameErrorCondition = false;
  final bool _streetNameErrorCondition = false;

  String? thProvinceValue;
  String? thAmphureValue;
  String? thTambonValue;
  String? zipcode;

  void getCurrentAmphure() async {
    amphureItems = await api.getAmphure(thProvinceValue);
    setState(() {
      _loadingAmphure = false;
    });
    // print('amphure items: $amphureItems');
  }

  void getCurrentTambon() async {
    tambonItems = await api.getTambon(thAmphureValue);
    setState(() {
      _loadingTambon = false;
    });
    // print('tambon items: $tambonItems');
  }

  void getCurrentZipcode() async {
    final zipname = thProvinceValue! + thAmphureValue! + thTambonValue!;
    zipcode = await api.getZipCode(zipname);
    _zipCodeController.text = zipcode!;
    setState(() {
      _loadingZipcode = false;
    });
  }

  // bool _loadingProvince = true;
  void getCurrentProvince() async {
    provinces = await api.getProvince();
    _countryController.text = 'ไทย';
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
      required Function(String?) onChanged,
      Function()? onTabFunction}) {
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
      onTap: onTabFunction,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentProvince();
  }

  @override
  Widget build(BuildContext context) {
    final homeNumberTextField = misc.importantTextField(
        textController: homeNumberController,
        errorTextCondition: _homeNumberErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.homeNumberSubject),
        subject: model.homeNumberSubject,
        filterPattern: RegExp(r'[0-9/-]'),
        onchangedFunction: (value) {
          if (value.isNotEmpty) {
            setState(() {
              _homeNumberErrorCondition = false;
            });
          } else {
            setState(() {
              _homeNumberErrorCondition = true;
            });
          }
        });
        
    final villageNumberTextField = misc.importantTextField(
        textController: villageNumberController,
        errorTextCondition: _villageNumberErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.villageNoSubject),
        subject: model.villageNoSubject,
        filterPattern: model.numberfilter,
        onTabFunction: () {
          if (homeNumberController.text.isNotEmpty) {
            setState(() {
              _homeNumberErrorCondition = false;
            });
          } else {
            setState(() {
              _homeNumberErrorCondition = true;
            });
          }
        },
        isimportant: false);
    final villageNameTextField = misc.importantTextField(
        textController: villageNameController,
        errorTextCondition: _villageNameErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.villageNameSubject),
        subject: model.villageNameSubject,
        filterPattern: model.allfilter,
        isimportant: false);
    final subStreetNameTextField = misc.importantTextField(
        textController: subStreetNameController,
        errorTextCondition: _subStreetNameErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.subStreetSubject),
        subject: model.subStreetSubject,
        filterPattern: model.allfilter,
        isimportant: false);
    final streetNameTextField = misc.importantTextField(
        textController: streetNameController,
        errorTextCondition: _streetNameErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.streetSubject),
        subject: model.streetSubject,
        filterPattern: model.allfilter,
        isimportant: false);
    final tambonDropdown = dropdownTHProvinceButtonBuilder(
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
    );

    final amphureDropdown = dropdownTHProvinceButtonBuilder(
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
    );

    final provinceDropdown = dropdownTHProvinceButtonBuilder(
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
    );

    final zipcodeTextField = misc.importantTextField(
        textController: zipCodeController,
        errorTextCondition: _zipcodeErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.zipcodeSubject),
        subject: model.zipcodeSubject,
        filterPattern: model.numberfilter);

    final countryTextField = misc.importantTextField(
        textController: countryController,
        errorTextCondition: _countryErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.countrySubject),
        subject: model.countrySubject,
        filterPattern: model.allfilter);

    // final otherAddressListTile = ListTile(
    //   title: const Text(model.otherAddressSubject),
    //   leading: Radio<CurrentAddress>(
    //     value: CurrentAddress.others,
    //     groupValue: _currentAddress,
    //     onChanged: (CurrentAddress? value) {
    //       setState(() {
    //         _currentAddress = value;
    //         getCurrentProvince();
    //       });
    //     },
    //   ),
    // );

    // final registeredAddressListTile = ListTile(
    //   title: const Text(model.registeredAddressSubject),
    //   leading: Radio<CurrentAddress>(
    //     value: CurrentAddress.registered,
    //     groupValue: _currentAddress,
    //     onChanged: (CurrentAddress? value) {
    //       setState(() {
    //         _currentAddress = value;
    //       });
    //     },
    //   ),
    // );

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
          Row(children: [
            const Icon(Icons.home),
            misc.subjectRichText(subject: model.registeredAddressSubject, fontsize: 25)
          ]),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(flex: 3, child: homeNumberTextField),
            const SizedBox(width: 10),
            Expanded(flex: 1, child: villageNumberTextField),
            const SizedBox(width: 10),
            Expanded(flex: 3, child: villageNameTextField),
            const SizedBox(width: 10),
            Expanded(flex: 3, child: subStreetNameTextField),
            const SizedBox(width: 10),
            Expanded(flex: 3, child: streetNameTextField),
          ]),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(flex: 3, child: tambonDropdown),
            const SizedBox(width: 10),
            Expanded(flex: 3, child: amphureDropdown),
            const SizedBox(width: 10),
            Expanded(flex: 3, child: provinceDropdown),
            const SizedBox(width: 10),
            Expanded(flex: 3, child: zipcodeTextField),
            const SizedBox(width: 10),
            Expanded(flex: 3, child: countryTextField),
          ]),
        ],
      ),
    );
  }
}
