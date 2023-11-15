import 'package:flutter/material.dart';

import 'package:ico_open/config/config.dart';
import 'package:ico_open/model/personal_info.dart';
import 'package:ico_open/model/preinfo.dart' as model;
import 'package:ico_open/personal_info/address.dart';
import 'package:ico_open/personal_info/advicer.dart';
import 'package:ico_open/personal_info/bank_account.dart';
import 'package:ico_open/personal_info/bottom.dart';
import 'package:ico_open/personal_info/occupation.dart';
import 'package:ico_open/personal_info/registered_address.dart';
import 'package:ico_open/personal_info/current_address.dart';

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
class _PersonalInformationState extends State<PersonalInformation> {
  // CurrentAddress? _currentAddress = CurrentAddress.registered;
  // final TextEditingController _homeNumber = TextEditingController();
  // final TextEditingController _thsurname = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   getZipCode();
  // }
  // bool _loadingProvince = true;
  // void getCurrentProvince() async {
  //   provinces = await getProvince();
  //   setState(() {
  //     _loadingProvince = false;
  //   });
  // }
 AddressModel? registered;

  @override
  Widget build(BuildContext context) {

  final userid = widget.id;
  double height = 50;
  //   getCurrentProvince();
  //   if (_loadingProvince) return const CircularProgressIndicator();
    return  Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HighSpace(height: height),
              const PersonalInformationHeader(),
              HighSpace(height: height),
              AddressWidget(address: registered),
                            const PersonalInformationRegisteredAddress(),
              HighSpace(height: height),
              const PersonalInformationCurrentAddress(),
              HighSpace(height: height),
              const PersonalInformationOccupation(),
              HighSpace(height: height),
              const PersonalInformationBankAccount(),
              HighSpace(height: height),
              // const PersonalInformationAdvisors(),
              // HighSpace(height: height),
              PersonalInformationBottom(id: userid),
              HighSpace(height: height),
            ],
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
    return Container(
      width: MediaQuery.of(context).size.width * displayWidth,
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
