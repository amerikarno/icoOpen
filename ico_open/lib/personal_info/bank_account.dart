import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ico_open/config/config.dart';

class PersonalInformationBankAccount extends StatefulWidget {
  const PersonalInformationBankAccount({super.key});

  @override
  State<PersonalInformationBankAccount> createState() =>
      _PersonalInformationBankAccountState();
}

enum BankAccounts { registered, unregistered }

class _PersonalInformationBankAccountState
    extends State<PersonalInformationBankAccount> {
  BankAccounts? _bankAccounts = BankAccounts.registered;
  final TextEditingController _bankAccountNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * displayWidth,
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: Colors.lightBlue.withOpacity(
          .3,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.location_on),
              const Text(
                'บัญชีธนาคารของท่าน (เพื่อความสะดวกในการถอนเงินและรับเงินปันผล)',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const Expanded(
              //   flex: 1,
              //   child: SizedBox(),
              // ),
              Expanded(
                flex: 1,
                child: ListTile(
                  title: const Text('ทำตอนนี้'),
                  leading: Radio<BankAccounts>(
                    value: BankAccounts.registered,
                    groupValue: _bankAccounts,
                    onChanged: (BankAccounts? value) {
                      setState(() {
                        _bankAccounts = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListTile(
                  title: const Text('ทำภายหลัง'),
                  leading: Radio<BankAccounts>(
                    value: BankAccounts.unregistered,
                    groupValue: _bankAccounts,
                    onChanged: (BankAccounts? value) {
                      setState(() {
                        _bankAccounts = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          (_bankAccounts == BankAccounts.registered)
              ? Column(
                  children: [
                    const Row(
                      children: [
                        Text('กรุณาระบุชื่อธนาคารก่อนกรอกชื่อสาขา'),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: BankTitleDropdownButton(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          flex: 1,
                          child: BankBranchDropdownButton(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _bankAccountNo,
                            decoration: const InputDecoration(
                              label: Text(
                                'เลขที่บัญชี',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
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
                      ],
                    )
                  ],
                )
              : const Column(),
        ],
      ),
    );
  }
}

class BankTitleDropdownButton extends StatefulWidget {
  const BankTitleDropdownButton({super.key});

  @override
  State<BankTitleDropdownButton> createState() =>
      _BankTitleDropdownButtonState();
}

const List<String> bankTitleLists = <String>[
  'รายรับประจำ',
  'รายรับพิเศษ',
  'ค่าเช่า / ขายของ',
  'เงินโบนัส / เงินรางวัล',
  'กำไรจากการลงทุน',
  'เงินออม',
];

class _BankTitleDropdownButtonState extends State<BankTitleDropdownButton> {
  String bankTitleDropdownValue = bankTitleLists.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        label: Text(
          'ธนาคาร',
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
          bankTitleDropdownValue = value!;
        });
      },
      items: bankTitleLists.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class BankBranchDropdownButton extends StatefulWidget {
  const BankBranchDropdownButton({super.key});

  @override
  State<BankBranchDropdownButton> createState() =>
      _BankBranchDropdownButtonState();
}

const List<String> bankBranchLists = <String>[
  'รายรับประจำ',
  'รายรับพิเศษ',
  'ค่าเช่า / ขายของ',
  'เงินโบนัส / เงินรางวัล',
  'กำไรจากการลงทุน',
  'เงินออม',
];

class _BankBranchDropdownButtonState extends State<BankBranchDropdownButton> {
  String bankBranchDropdownValue = bankBranchLists.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        label: Text(
          'ชื่อสาขา',
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
          bankBranchDropdownValue = value!;
        });
      },
      items: bankBranchLists.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
