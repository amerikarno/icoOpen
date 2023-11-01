import 'package:flutter/material.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<StatefulWidget> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final TextEditingController _homeNumber = TextEditingController();
  // final TextEditingController _thsurname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // widthFactor: MediaQuery.of(context).size.width * .8,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
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
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
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
            ),
          const SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              padding: const EdgeInsets.all(50),
              decoration: BoxDecoration(
                  color: Colors.lightBlue.withOpacity(
                    .3,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: const Row(
                children: [
                  Icon(Icons.location_on),
                   Text(
                    'ที่อยู่ปัจจุบัน',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
