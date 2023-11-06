import 'package:flutter/material.dart';

import 'package:ico_open/config/config.dart';


class PersonalInformationRegisteredAddress extends StatefulWidget {
  const PersonalInformationRegisteredAddress({
    super.key,
  });

  @override
  State<PersonalInformationRegisteredAddress> createState() =>
      _PersonalInformationRegisteredAddressState();
}

class _PersonalInformationRegisteredAddressState
    extends State<PersonalInformationRegisteredAddress> {
  final TextEditingController _homeNumber = TextEditingController();

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
              Icon(Icons.home),
              Text(
                'ที่อยู่ตามบัตรประชาชน',
                style: TextStyle(
                  fontSize: 20,
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
      ),
    );
  }
}

