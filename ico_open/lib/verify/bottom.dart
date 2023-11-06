import 'package:flutter/material.dart';
import 'package:ico_open/config/config.dart';
import 'package:ico_open/customer_evaluate/page.dart';

class VerifyBottom extends StatelessWidget {
  const VerifyBottom({super.key});

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
                            return const CustomerEvaluate();
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
               ],
          ),
        ],
      ),
    );
  }
}
