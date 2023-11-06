import 'package:flutter/material.dart';

import 'package:ico_open/config/config.dart';
import 'package:ico_open/verify/bottom.dart';
import 'package:ico_open/verify/email_mobile.dart';

// enum CurrentAddress { registered, others }

// const double displayWidth = 0.6;

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<StatefulWidget> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  // CurrentAddress? _currentAddress = CurrentAddress.registered;
  // final TextEditingController _homeNumber = TextEditingController();
  // final TextEditingController _thsurname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HighSpace(height: 50),
              VerifyHeader(),
              HighSpace(height: 20),
              Text(
                'กรุณายืนยันหมายเลข "โทรศัพท์" และ "อีเมล์" ของท่าน',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                ),
              ),
              HighSpace(height: 20),
              VerifyEmailMobile(),
              HighSpace(height: 50),
              // VerifyResults(),
              // HighSpace(height: 50),
              // CustomerFATCA(),
              // HighSpace(height: 50),
              // CustomerAgreement(),
              // HighSpace(height: 50),
              // VerifyAdvisors(),
              // HighSpace(height: 50),
              VerifyBottom(),
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

class VerifyHeader extends StatelessWidget {
  const VerifyHeader({super.key});

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
        'ยืนยันหมายเลขโทรศัพท์ และ อีเมล',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
