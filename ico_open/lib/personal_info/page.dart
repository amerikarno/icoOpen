import 'package:flutter/material.dart';

import 'package:ico_open/config/config.dart';
import 'package:ico_open/idcard/page.dart';
import 'package:ico_open/model/personal_info.dart' as modelPI;
import 'package:ico_open/model/model.dart' as model;
import 'package:ico_open/misc/misc.dart' as misc;
import 'package:ico_open/personal_info/bank_account.dart';
import 'package:ico_open/personal_info/api.dart' as api;
import 'package:ico_open/personal_info/occupation.dart';
import 'package:ico_open/personal_info/registered_address.dart';
import 'package:ico_open/personal_info/current_address.dart';
import 'package:ico_open/personal_info/registered_address_widget.dart';
import 'package:ico_open/personal_info/widgets.dart';

// enum CurrentAddress { registered, others }

// const double displayWidth = 0.6;

class PersonalInformation extends StatefulWidget {
  final String id;
  const PersonalInformation({super.key, required this.id});
  // final model.Preinfo preinfo;

  @override
  State<StatefulWidget> createState() => _PersonalInformationState();
}

List<String> provinces = [];
// variables for personal addresses information.
// model.AddressModel? registeredAddress;
var registeredAddress = modelPI.AddressModel(
  typeOfAddress: 'r',
  homenumber: '',
  zipcode: 0,
  countryName: '',
  condition: modelPI.Condition(homenumber: false),
);
var currentAddress = modelPI.AddressModel(
  typeOfAddress: 'r',
  homenumber: '',
  zipcode: 0,
  countryName: '',
  condition: modelPI.Condition(homenumber: false),
);
var othersAddress = modelPI.AddressModel(
  typeOfAddress: 'r',
  homenumber: '',
  zipcode: 0,
  countryName: '',
  condition: modelPI.Condition(homenumber: false),
);
var occupation = modelPI.OccupationModel(
  sourceOfIncome: '',
  currentOccupation: '',
  officeName: '',
  positionName: '',
  typeOfBusiness: '',
  salaryRange: '',
);
var firstBank = modelPI.BankAccountModel(
  bankName: '',
  bankAccountID: '',
  serviceType: 'dw',
);
var secondBank = modelPI.BankAccountModel(
  bankName: '',
  bankAccountID: '',
  serviceType: 'd',
);

class _PersonalInformationState extends State<PersonalInformation> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getCurrentProvince();
  }

  double height = 50;
  // modelPI.AddressModel? registeredAddress;

  String? thProvinceValue;
  String? thAmphureValue;
  String? thTambonValue;
  String? zipcode;

  List<String> provinceItems = provinces;
  final thProvinceLable = 'จังหวัด';
  final thAmphureLable = 'เขตอำเภอ';
  List<String> amphureItems = [];
  final thTambonLable = 'แขวงตำบล';
  List<String> tambonItems = [];
  // controller variables
  final rHomeNumberController = TextEditingController();
  final rVillageNumberController = TextEditingController();
  final rVillageNameController = TextEditingController();
  final rSubStreetNameController = TextEditingController();
  final rStreetNameController = TextEditingController();
  final rZipCodeController = TextEditingController();
  final rCountryController = TextEditingController();
  final rOfficeNameController = TextEditingController();
  final rPositionNameController = TextEditingController();

// error condition
  final bool _villageNumberErrorCondition = false;
  final bool _villageNameErrorCondition = false;
  final bool _subStreetNameErrorCondition = false;
  final bool _streetNameErrorCondition = false;

  bool _loadingAmphure = true;
  bool _loadingTambon = true;
  bool _loadingZipcode = true;

  Widget dropdownButtonBuilderFunction(
      {required String? value,
      required String label,
      required List<String> items,
      required Function(String?) onChanged,
      required bool condition,
      required String errorText,
      Function()? onTabFunction}) {
    return DropdownButtonFormField(
      value: value,
      decoration: InputDecoration(
        errorText: condition ? errorText : null,
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

  void getCurrentProvince() async {
    provinces = await api.getProvince();
    rCountryController.text = 'ไทย';
    // log('current provinces: $provinces');
    setState(() {
      provinceItems = provinces;
      // thProvinceValue = provinceItems.first;
    });
  }

  void getCurrentZipcode() async {
    final zipname = thProvinceValue! + thAmphureValue! + thTambonValue!;
    zipcode = await api.getZipCode(zipname);
    rZipCodeController.text = zipcode!;
    setState(() {
      _loadingZipcode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userid = widget.id;
    final homeNumberTextField = misc.importantTextField(
        textController: rHomeNumberController,
        errorTextCondition: homeNumberErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.homeNumberSubject),
        subject: model.homeNumberSubject,
        filterPattern: RegExp(r'[0-9/-]'),
        onchangedFunction: (value) {
          if (value.isNotEmpty) {
            print('not empty: $value');
            setState(() {
              registeredAddress.homenumber = value;
              registeredAddress.condition.homenumber = false;
            });
          } else {
            setState(() {
              registeredAddress.condition.homenumber = true;
            });
          }
        });

    final villageNumberTextField = misc.importantTextField(
        textController: rVillageNumberController,
        errorTextCondition: registeredAddress.condition.homenumber,
        errorTextMessage: misc.thErrorMessage(model.villageNoSubject),
        subject: model.villageNoSubject,
        filterPattern: model.numberfilter,
        onchangedFunction: (value) {
          if (value.isNotEmpty) {
            print('not empty: $value');
            setState(() {
              registeredAddress.villageNumber = value;
            });
          }
        },
        onTabFunction: () {
          if (rHomeNumberController.text.isNotEmpty) {
            setState(() {
              registeredAddress.condition.homenumber = false;
            });
          } else {
            setState(() {
              registeredAddress.condition.homenumber = true;
            });
          }
        },
        isimportant: false);
    final villageNameTextField = misc.importantTextField(
        textController: rVillageNameController,
        errorTextCondition: _villageNameErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.villageNameSubject),
        subject: model.villageNameSubject,
        filterPattern: model.allfilter,
        onchangedFunction: (value) {
          if (value.isNotEmpty) {
            print('not empty: $value');
            setState(() {
              registeredAddress.villageName = value;
            });
          }
        },
        isimportant: false);
    final subStreetNameTextField = misc.importantTextField(
        textController: rSubStreetNameController,
        errorTextCondition: _subStreetNameErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.subStreetSubject),
        subject: model.subStreetSubject,
        filterPattern: model.allfilter,
        onchangedFunction: (value) {
          if (value.isNotEmpty) {
            print('not empty: $value');
            setState(() {
              registeredAddress.subStreetName = value;
            });
          }
        },
        isimportant: false);
    final streetNameTextField = misc.importantTextField(
        textController: rStreetNameController,
        errorTextCondition: _streetNameErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.streetSubject),
        subject: model.streetSubject,
        filterPattern: model.allfilter,
        onchangedFunction: (value) {
          if (value.isNotEmpty) {
            print('not empty: $value');
            setState(() {
              registeredAddress.streetName = value;
            });
          }
        },
        isimportant: false);
    final tambonDropdown = dropdownButtonBuilderFunction(
      value: thTambonValue,
      label: thTambonLable,
      items: tambonItems,
      condition: tambonErrorCondition,
      errorText: misc.thErrorMessage(thTambonLable),
      onChanged: (value) {
        setState(() {
          registeredAddress.subDistrictName = value;
          thTambonValue = value;
          getCurrentZipcode();
        });
        if (_loadingZipcode) {
          return const CircularProgressIndicator();
        }
      },
    );

    final amphureDropdown = dropdownButtonBuilderFunction(
      value: thAmphureValue,
      label: thAmphureLable,
      items: amphureItems,
      condition: amphureErrorCondition,
      errorText: misc.thErrorMessage(thAmphureLable),
      onChanged: (String? value) {
        setState(() {
          registeredAddress.districtName = value;
          thAmphureValue = value;
          thTambonValue = null;
          getCurrentTambon();
          // if (thTambonValue!.isNotEmpty) {thTambonValue = null;}
        });
        if (_loadingTambon) {
          return const CircularProgressIndicator();
        }
      },
    );

    final provinceDropdown = dropdownButtonBuilderFunction(
      value: thProvinceValue,
      label: thProvinceLable,
      items: provinceItems,
      condition: provinceErrorCondition,
      errorText: misc.thErrorMessage(thProvinceLable),
      onChanged: (String? value) {
        setState(
          () {
            registeredAddress.provinceName = value;
            thProvinceValue = value;
            thAmphureValue = null;
            thTambonValue = null;
            getCurrentAmphure();
          },
        );
        if (_loadingAmphure) {
          return const CircularProgressIndicator();
        }
      },
    );

    final zipcodeTextField = misc.importantTextField(
        textController: rZipCodeController,
        errorTextCondition: zipcodeErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.zipcodeSubject),
        subject: model.zipcodeSubject,
        onchangedFunction: (value) {
          if (value.isNotEmpty) {
            print('not empty: $value');
            setState(() {
              registeredAddress.zipcode = int.parse(value);
              zipcodeErrorCondition = false;
            });
          } else {
            setState(() {
              zipcodeErrorCondition = true;
            });
          }
        },
        filterPattern: model.numberfilter);

    final rcountryTextField = misc.importantTextField(
        textController: rCountryController,
        errorTextCondition: countryErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.countrySubject),
        subject: model.countrySubject,
        onchangedFunction: (value) {
          if (value.isNotEmpty) {
            print('not empty: $value');
            setState(() {
              registeredAddress.countryName = value;
              countryErrorCondition = false;
            });
          } else {
            setState(() {
              countryErrorCondition = true;
            });
          }
        },
        filterPattern: model.allfilter);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * displayWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HighSpace(height: height),
                const PersonalInformationHeader(),
                HighSpace(height: height),

                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue.withOpacity(.3),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(children: [
                    Row(children: [
                      const Icon(Icons.home),
                      misc.subjectRichText(
                          subject: model.registeredAddressSubject, fontsize: 25)
                    ]),
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
                      Expanded(flex: 3, child: rcountryTextField),
                    ]),
                  ]),
                ),

                HighSpace(height: height),
                const PersonalInformationCurrentAddress(),
                HighSpace(height: height),
                const PersonalInformationOccupation(),
                HighSpace(height: height),
                const PersonalInformationBankAccount(),
                HighSpace(height: height),
                // const PersonalInformationAdvisors(),
                // HighSpace(height: height),
                // PersonalInformationBottom(id: userid),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FloatingActionButton(
                        shape: const CircleBorder(),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const IDCardPage();
                              },
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_circle_left,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'ย้อนกลับ',
                      style: TextStyle(fontSize: 15),
                    ),
                    const Expanded(
                      flex: 30,
                      child: SizedBox(),
                    ),
                    const Text(
                      'ถัดไป',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: FittedBox(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.orange,
                          onPressed: () {
                            // print('registered home number: ${registeredAddress.homenumber} ${page.registeredAddress.villageName} ${page.registeredAddress.subStreetName} ${page.registeredAddress.streetName}, ${page.registeredAddress.typeOfAddress}');
                            // print('current home number: ${page.currentAddress.homenumber}, ${page.currentAddress.typeOfAddress}');
                            // print('others home number: ${page.othersAddress.homenumber}, ${page.othersAddress.typeOfAddress}');
                            // print('occupation: ${page.occupation.sourceOfIncome}, ${page.occupation.currentOccupation}, ${page.occupation.officeName}, ${page.occupation.typeOfBusiness}, ${page.occupation.positionName}, ${page.occupation.salaryRange}');
                            // print('1st bank account: ${page.firstBank.bankAccountID}, ${page.firstBank.bankName}, ${page.firstBank.bankBranchName}, ${page.firstBank.serviceType}');
                            // print('2st bank account: ${page.secondBank.bankAccountID}, ${page.secondBank.bankName}, ${page.secondBank.bankBranchName}, ${page.secondBank.serviceType}');

                            if (registeredAddress.homenumber.isEmpty) {
                              setState(() {
                                homeNumberErrorCondition = true;
                              });
                            }
                            // print(_lasercodestr);
                            // if (registered.homeNumberController.text.isNotEmpty) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) {
                            //         return CustomerEvaluate(id: id);
                            //       },
                            //     ),
                            //   );
                            // }
                          },
                          child: const Icon(
                            Icons.arrow_circle_right,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                HighSpace(height: height),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HighSpace extends StatelessWidget {
  const HighSpace({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class PersonalInformationHeader extends StatelessWidget {
  const PersonalInformationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * displayWidth,
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
          color: Colors.lightGreen.withOpacity(
            .3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: const Text(
        'กรอกข้อมูลส่วนตัว',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// class PersonalInformationCurrentAddress extends StatefulWidget {
//   const PersonalInformationCurrentAddress({super.key});

//   @override
//   State<PersonalInformationCurrentAddress> createState() =>
//       _PersonalInformationCurrentAddressState();
// }

// class _PersonalInformationCurrentAddressState
//     extends State<PersonalInformationCurrentAddress> {
//   CurrentAddress? _currentAddress = CurrentAddress.registered;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * displayWidth,
//       padding: const EdgeInsets.all(50),
//       decoration: BoxDecoration(
//           color: Colors.lightBlue.withOpacity(
//             .3,
//           ),
//           borderRadius: const BorderRadius.all(Radius.circular(10))),
//       child: Row(
//         children: [
//           const Icon(Icons.location_on),
//           const Text(
//             'ที่อยู่ปัจจุบัน',
//             style: TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Expanded(
//             flex: 1,
//             child: SizedBox(),
//           ),
//           Expanded(
//             flex: 1,
//             child: ListTile(
//               title: const Text('ที่อยู่ตามบัตรประชาชน'),
//               leading: Radio<CurrentAddress>(
//                 value: CurrentAddress.registered,
//                 groupValue: _currentAddress,
//                 onChanged: (CurrentAddress? value) {
//                   setState(() {
//                     _currentAddress = value;
//                   });
//                 },
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: ListTile(
//               title: const Text('ที่อยู่อื่น (โปรดระบุ)'),
//               leading: Radio<CurrentAddress>(
//                 value: CurrentAddress.others,
//                 groupValue: _currentAddress,
//                 onChanged: (CurrentAddress? value) {
//                   setState(() {
//                     _currentAddress = value;
//                   });
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
