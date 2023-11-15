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
  final String id;
  const CustomerEvaluate({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _CustomerEvaluateState();
}

class _CustomerEvaluateState extends State<CustomerEvaluate> {
  // CurrentAddress? _currentAddress = CurrentAddress.registered;
  // final TextEditingController _homeNumber = TextEditingController();
  // final TextEditingController _thsurname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userid = widget.id;
    double height = 50;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              HighSpace(height: height),
              const CustomerEvaluateHeader(),
              HighSpace(height: height),
              const CustomerEvaluateScores(),
              HighSpace(height: height),
              const CustomerEvaluateResults(),
              HighSpace(height: height),
              const CustomerFATCA(),
              HighSpace(height: height),
              const CustomerAgreement(),
              HighSpace(height: height),
              // CustomerEvaluateAdvisors(),
              // HighSpace(height: 50),
              CustomerEvaluateBottom(id:userid),
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
