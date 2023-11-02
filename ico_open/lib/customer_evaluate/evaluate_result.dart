import 'package:flutter/material.dart';

import 'package:ico_open/config/config.dart';
import 'package:ico_open/personal_info/page.dart';

enum CurrentAddress { registered, others }

class CustomerEvaluateResults extends StatefulWidget {
  const CustomerEvaluateResults({super.key});

  @override
  State<CustomerEvaluateResults> createState() =>
      _CustomerEvaluateResultsState();
}

class _CustomerEvaluateResultsState extends State<CustomerEvaluateResults> {
  // CurrentAddress? _currentAddress = CurrentAddress.registered;
  // final TextEditingController _homeNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * displayWidth,
      padding: const EdgeInsets.all(paddingValue),
      decoration: BoxDecoration(
          color: Colors.lightBlue.withOpacity(
            .3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: const Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Text(
                    'ผลการประเมินความเหมาะสมในการลงทุน',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 5,
                ),
              ),
            ],
          ),
          HighSpace(height: 20),
          SizedBox(
            height: 150,
            child: Row(
              children: [
                VerticalDivider(
                  width: 20,
                  thickness: 1,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ผลคะแนนที่ท่านทำได้',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  width: 20,
                  thickness: 1,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'วิเคราะห์ผล',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'ท่านเป็นนักลงทุนประเภท',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  width: 20,
                  thickness: 1,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ผลคะแนนที่ท่านทำได้',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerRisksDropdownButton extends StatefulWidget {
  const CustomerRisksDropdownButton({super.key});

  @override
  State<CustomerRisksDropdownButton> createState() =>
      _CustomerRisksDropdownButtonState();
}

const List<String> customerRiskLists = <String>[
  'เสี่ยงต่ำ',
  'เสี่ยงปานกลางค่อนข้างต่ำ',
  'เสี่ยงปานกลางค่อนข้างสูง',
  'เสี่ยงสูง',
  'เสี่ยงสูงมาก',
];

class _CustomerRisksDropdownButtonState
    extends State<CustomerRisksDropdownButton> {
  String customerRiskDropdownValue = customerRiskLists.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        label: Text(
          'เลือกระดับความเสี่ยงประเภทนักลงทุน',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
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
          customerRiskDropdownValue = value!;
        });
      },
      items: customerRiskLists.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class SuitableTest extends StatelessWidget {
  const SuitableTest({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
              'กรุณาเลือกข้อที่ตรงกับท่านมากที่สุดเพื่อท่านจะได้ทราบว่าท่านเหมาะที่จะลงทุนในทรัพย์สินประเภทใด'),
          content: SizedBox(
            width: (MediaQuery.of(context).size.width * 0.6),
            child: const SingleChildScrollView(
              padding: EdgeInsetsDirectional.all(paddingValue),
              child: Text(agreement),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
              child: const Text(
                'OK',
              ),
            ),
          ],
        ),
      ),
      child: const Text(
        'ศึกษาหรือแก้ไขรายละเอียดแบบประเมิน',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 15,
          color: Colors.orange,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

const String agreement = "agreement";
