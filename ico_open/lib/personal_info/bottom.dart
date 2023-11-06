import 'package:flutter/material.dart';
import 'package:ico_open/config/config.dart';
import 'package:ico_open/customer_evaluate/page.dart';
import 'package:ico_open/idcard/page.dart';

class PersonalInformationBottom extends StatelessWidget {
  const PersonalInformationBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * displayWidth,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: FittedBox(
                  alignment: Alignment.bottomLeft,
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
              ),
              const SizedBox(
                width: 5,
              ),
              const Text('ย้อนกลับ', style: TextStyle(fontSize: 15),),
              const Expanded(
                flex: 30,
                child: SizedBox(),
              ),
              const Text('ถัดไป', style: TextStyle(fontSize: 15),),
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
                      // print(_lasercodestr);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CustomerEvaluate();
                          },
                        ),
                      );
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
        ],
      ),
    );
  }
}
