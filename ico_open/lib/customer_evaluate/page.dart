import 'package:flutter/material.dart';

import 'package:ico_open/config/config.dart';
import 'package:ico_open/customer_evaluate/agreement.dart';
import 'package:ico_open/customer_evaluate/evaluate.dart';
import 'package:ico_open/customer_evaluate/evaluate_result.dart';
import 'package:ico_open/customer_evaluate/fatca.dart';
import 'package:ico_open/customer_evaluate/bottom.dart';

// enum CurrentAddress { registered, others }

// const double displayWidth = 0.6;

class CustomerEvaluate extends StatefulWidget {
  const CustomerEvaluate({super.key});

  @override
  State<StatefulWidget> createState() => _CustomerEvaluateState();
}

class _CustomerEvaluateState extends State<CustomerEvaluate> {
  // CurrentAddress? _currentAddress = CurrentAddress.registered;
  // final TextEditingController _homeNumber = TextEditingController();
  // final TextEditingController _thsurname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              HighSpace(height: 50),
              CustomerEvaluateHeader(),
              HighSpace(height: 50),
              CustomerEvaluateScores(),
              HighSpace(height: 50),
              CustomerEvaluateResults(),
              HighSpace(height: 50),
              CustomerFATCA(),
              HighSpace(height: 50),
              CustomerAgreement(),
              HighSpace(height: 50),
              // CustomerEvaluateAdvisors(),
              // HighSpace(height: 50),
              CustomerEvaluateBottom(),
              HighSpace(height: 50),
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

class CustomerEvaluateHeader extends StatelessWidget {
  const CustomerEvaluateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * displayWidth,
      padding: const EdgeInsets.all(pagePaddingValue),
      decoration: BoxDecoration(
          color: Colors.lightGreen.withOpacity(
            .3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: const Text(
        'ประเมินความเหมาะสมในการลงทุน',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
