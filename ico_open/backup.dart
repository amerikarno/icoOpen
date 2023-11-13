import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ico_open/idcard/page.dart';
import 'package:ico_open/model/preinfo.dart';
import 'package:ico_open/misc/misc.dart' as misc;

import 'package:ico_open/preinfo/personal_agreement.dart';
// import 'package:ico_open/model/model.dart';

// import 'package:ico_open/preinfo/title.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// String enDropdownValue = enTitles.first;

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _thname = TextEditingController();
  final TextEditingController _thsurname = TextEditingController();
  final TextEditingController _enname = TextEditingController();
  final TextEditingController _ensurname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobileno = TextEditingController();

  var _emailError = 'กรุณาใส่อีเมล';
  var _mobilenoError = 'กรุณาใส่หมายเลขโทรศัพท์มือถือ';
  // FocusNode _focusEmail = FocusNode();

  bool _validateTHName = false;
  bool _validateTHSurName = false;
  bool _validateEnName = false;
  bool _validateEnSurName = false;
  bool _validateEmail = false;
  bool _validateMobileNo = false;
  bool _passedVeridateEmail = false;

  bool isPassedMobileChecked = false;
  bool isPassedEmailChecked = false;

  bool? _loadingEmail;
  bool? _loadingMobile;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  Future<bool> verifyEmail(String email) async {
    @override
    void initState() {
      _loadingEmail = true;
    }

    // HttpResponse response;
    log('email state: $_loadingEmail, $_passedVeridateEmail begin...');
    if (email.isEmpty) {
      setState(() {
        if (!_validateEmail) {
          _validateEmail = true;
        }
      });
    } else {
      final url = Uri(
        scheme: 'http',
        host: 'localhost',
        port: 1323,
        path: 'verify/email/$email',
      );
      var response = await http.get(url);

      log(
        'url:',
        name: url.toString(),
      );
      log('respons code:', name: response.statusCode.toString());
      log('respons body:', name: response.body.toString());

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log('start to verify');
        log('data', name: data.toString());
        if (data['isRegisteredEmail'] == 'true') {
          log('[true]registered email: ${data['registeredEmail'].toString()}');
        } else {
          log('[else]registered email: ${data['registeredEmail'].toString()}');
          _passedVeridateEmail = true;
          log('verified email: ${_passedVeridateEmail.toString()}');
        }
        setState(() {
          isPassedEmailChecked = _passedVeridateEmail;
          _validateEmail = false;
          _loadingEmail = false;
        });
        log('email state: $_loadingEmail end...');
      }

      if (data['isInvalidEmailFormat']) {
        log('invalid email format', name: _passedVeridateEmail.toString());
        setState(() {
          _emailError = 'กรุณาใส่อีเมลให้ถูกต้อง';
          _validateEmail = true;
          _loadingEmail = false;
          // isPassedEmailChecked = false;
        });
      }
    }

    log('return: $_passedVeridateEmail');
    return _passedVeridateEmail;
  }

  // Future<void> getIsPassedValidateEmail(String email) async {
  //   final completer = Completer();
  //   bool? passed;
  //   if (_loadingEmail) {
  //     passed = await _verifyEmail(email);

  //     return getIsPassedValidateEmail(email);
  //   } else {
  //     completer.complete();
  //   }

  //   log("is pass email checking: $passed");
  //   setState(() {
  //     isPassedEmailChecked = _passedVeridateEmail;
  //     _loadingEmail = false;
  //   });
  //   // if (_loadingEmail) {
  //   //   const CircularProgressIndicator();
  //   // }
  //   // log("before loading email: $_loadingEmail");
  //   while (_loadingEmail) {
  //     const CircularProgressIndicator();
  //   }
  //   // log("after loading email: $_loadingEmail");
  // }

  Future<bool> _verifyMobileNo(String mobileno) async {
    if (mobileno.isEmpty) {
      log('email is empty', name: _passedVeridateEmail.toString());
      setState(() {
        _validateMobileNo = true;
      });
    } else {
      final url = Uri(
        scheme: 'http',
        host: 'localhost',
        port: 1323,
        path: 'verify/mobile/$mobileno',
      );
      var response = await http.get(url).timeout(
            const Duration(seconds: 1),
            onTimeout: () => http.Response('error', 408),
          );
      log(
        'url:',
        name: url.toString(),
      );
      log('respons code:', name: response.statusCode.toString());
      log('respons body:', name: response.body.toString());

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log('start to verify');
        log('data', name: data.toString());
        if (data['isRegisteredMobileNo']) {
          log('registered mobile no',
              name: data['registeredMobileNo'].toString());
        } else {
          log('registered mobile no',
              name: data['registeredMobileNo'].toString());
          _passedVeridateEmail = true;
          log('verified mobile no', name: _passedVeridateEmail.toString());
        }
        setState(() {
          _validateMobileNo = false;
          _loadingMobile = false;
          // isPassedMobileChecked = true;
        });
      }

      if (data['isInvalidMobileNoFormat']) {
        log('invalid mobile format', name: _passedVeridateEmail.toString());
        setState(() {
          _mobilenoError = 'กรุณาใส่หมายเลขโทรศัพท์มือถือให้ถูกต้อง';
          _validateMobileNo = true;
          _loadingMobile = false;
          // isPassedMobileChecked = false;
        });
      }
    }
    print('verify mobile');
    return Future.delayed(const Duration(seconds: 5), () => !_validateMobileNo);
  }

  void getIsPassedValidateMobile(String mobile) async {
    final passed = await _verifyMobileNo(mobile);
    setState(() {
      isPassedMobileChecked = passed;
      _loadingMobile = false;
    });
    print('verify mobile2');
    if (_loadingMobile!) {
      const CircularProgressIndicator();
    }
  }

  final thList = [
    'นาย',
    'นาง',
    'นางสาว',
  ];
  final engList = [
    'Mr.',
    'Mrs.',
    'Ms.',
  ];

  String? engToTh(String? eng) {
    if (eng == null) return null;
    final index = engList.indexOf(eng);
    if (index >= 0) {
      log('eng: ${thList[index]}');
      return thList[index];
    }
    return null;
  }

  String? thToEng(String? th) {
    if (th == null) return null;
    final index = thList.indexOf(th);
    if (index >= 0) {
      log('th: ${engList[index]}');
      return engList[index];
    }
    return null;
  }

  Widget nextButtonWidget({
    required Function() onpressed,
  }) {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: onpressed,
      child: const Icon(
        Icons.arrow_right_alt,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  String? thValue;
  String? engValue;

  Widget dropdownButtonBuilder(
      {required String? value,
      required String label,
      required List<String> items,
      required Function(String?) onChanged}) {
    return DropdownButtonFormField(
      value: value,
      decoration: InputDecoration(
        label: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      onChanged: (String? value) {
        setState(() {
          onChanged(value);
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  final thLabel = 'คำนำหน้าชื่อ (ภาษาไทย)';
  final engLabel = 'คำนำหน้าชื่อ (ภาษาอังกฤษ)';

  @override
  Widget build(BuildContext context) {
    final thField = dropdownButtonBuilder(
      value: thValue,
      label: thLabel,
      items: thList,
      onChanged: (value) {
        thValue = value!;
        engValue = thToEng(value);
      },
    );
    final engField = dropdownButtonBuilder(
      value: engValue,
      label: engLabel,
      items: engList,
      onChanged: (value) {
        thValue = value!;
        engValue = engToTh(value);
      },
    );

    Widget emailField;
    if (_loadingEmail!) {
      emailField = const CircularProgressIndicator();
    }

    emailField = misc.importantTextField(
      textController: _email,
      errorTextCondition: _validateEmail,
      errorTextMessage: _emailError,
      subject: 'อีเมล',
      filterPattern: RegExp(r'[a-zA-Z0-9@.]'),
      onsubmittedFunction: (value) {
        setState(() {
          verifyEmail(value);
        });
      },
    );
    Widget mobileField;
    if (_loadingMobile!) {
      mobileField = const CircularProgressIndicator();
    }
    mobileField = misc.importantTextField(
      textController: _mobileno,
      errorTextCondition: _validateMobileNo,
      errorTextMessage: _mobilenoError,
      subject: 'หมายเลขโทรศัพท์มือถือ',
      filterPattern: RegExp(r'[0-9]'),
    );

    Widget nextbutton;
    if (_loadingEmail!) {
      nextbutton = const CircularProgressIndicator();
    } else {
      nextbutton = nextButtonWidget(onpressed: () {
        setState(() {
          verifyEmail(_email.text);
          _verifyMobileNo(_mobileno.text);
        });
        if (_loadingEmail! || _loadingMobile!) {
          print('loading email: $_loadingEmail, mobile: $_loadingMobile');
          return const CircularProgressIndicator();
        } else {
          print(
              """validate: $_validateTHName, $_validateTHSurName, $_validateEnName, $_validateEnSurName, 
                                $_validateEmail, $_validateMobileNo, $isPersonalAgreementChecked, $isPassedEmailChecked, $isPassedMobileChecked""");
        }
      });
    }

    var body = Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const SizedBox(
                child: Text(
                  'กรุณากรอกข้อมูลเพื่อเปิดบัญชี',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 230,
                child: thField,
                // child: THdropdownButton(),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 230,
                    child: misc.importantTextField(
                      textController: _thname,
                      errorTextCondition: _validateTHName,
                      errorTextMessage: 'กรุณาใส่ชื่อ (ภาษาไทย)',
                      subject: 'ชื่อ (ภาษาไทย)',
                      filterPattern: RegExp(r'[ก-๛]'),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 5,
                    child: misc.importantTextField(
                      textController: _thsurname,
                      errorTextCondition: _validateTHSurName,
                      errorTextMessage: 'กรุณาใส่นามสกุล (ภาษาไทย)',
                      subject: 'นามสกุล (ภาษาไทย)',
                      filterPattern: RegExp(r'[ก-๛]'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 230,
                child: engField,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 230,
                    child: misc.importantTextField(
                        textController: _enname,
                        errorTextCondition: _validateEnName,
                        errorTextMessage: 'กรุณาใส่ชื่อ (ภาษาอังกฤษ)',
                        subject: 'ชื่อ (ภาษาอังกฤษ)',
                        filterPattern: RegExp(r'[a-zA-Z]')),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 5,
                    child: misc.importantTextField(
                      textController: _ensurname,
                      errorTextCondition: _validateEnSurName,
                      errorTextMessage: 'กรุณาใส่นามสกุล (ภาษาอังกฤษ)',
                      subject: 'นามสกุล (ภาษาอังกฤษ)',
                      filterPattern: RegExp(
                        r'[a-zA-Z]',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                child: Text(
                  'ข้อมูลสำหรับรับ Username, Password และเอกสารจากทางบริษัทฯ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.lightBlue,
                  ),
                  Expanded(
                    flex: 3,
                    child: emailField,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.phone_iphone,
                    color: Colors.lightBlue,
                  ),
                  Expanded(
                    // width: 300,
                    flex: 5,
                    child: mobileField,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(children: [
                Expanded(flex: 1, child: CheckboxPersonalAggreement()),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Wrap(
                        children: [
                          Text(
                            """ข้าพเจ้าได้อ่านและตกลงตามข้อมกำหนดและเงื่อนไขและรับทราบนโยบายความเป็นส่วนตัว ซึ่งระบุวิธีการที่บริษัท ฟินันเซีย ดิจิตทัล แอสแซท จำกัด("บริษัท")""",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          PersonalAgreement(),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
              Expanded(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    SizedBox(
                      width: 500,
                      child: RichText(
                        text: const TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: 'ข้อมูลสำคัญกรุณากรอกให้ครบถ้วย',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: FittedBox(
                          alignment: Alignment.bottomRight, child: nextbutton
                          // child: FloatingActionButton(
                          //   backgroundColor: Colors.orange,
                          //   onPressed: () {
                          //       _verifyEmail(_email.text).timeout(const Duration(milliseconds: 100)).then((value) => isPassedEmailChecked);
                          //       getIsPassedValidateMobile(_mobileno.text);
                          //     setState(() {
                          //       print('loading email: $_loadingEmail');
                          //       // if (_loadingEmail) {
                          //       //   body = CircularProgressIndicator();
                          //       // }
                          //       // print('loading mobile: $_loadingMobile');
                          //       // if (_loadingMobile) {
                          //       //   body = CircularProgressIndicator();
                          //       // }
                          //     });
                          //     print(
                          //         """title: $thValue name: ${_thname.text} surname: ${_thsurname.text}
                          //         title: $engValue name: ${_enname.text} surname: ${_ensurname.text}
                          //         email: ${_email.text}, mobile: ${_mobileno.text}, agreement: $isPersonalAgreementChecked""");

                          //     print(
                          //         """validate: $_validateTHName, $_validateTHSurName, $_validateEnName, $_validateEnSurName,
                          //         $_validateEmail, $_validateMobileNo, $isPersonalAgreementChecked, $isPassedEmailChecked, $isPassedMobileChecked""");
                          //     if (_thname.text.trim().isNotEmpty &&
                          //         _thsurname.text.trim().isNotEmpty &&
                          //         _enname.text.trim().isNotEmpty &&
                          //         _ensurname.text.trim().isNotEmpty &&
                          //         _email.text.trim().isNotEmpty &&
                          //         _mobileno.text.trim().isNotEmpty &&
                          //         isPersonalAgreementChecked &&
                          //         isPassedEmailChecked &&
                          //         isPassedMobileChecked) {
                          //       print("""Go to next page with data:
                          //         title: $thValue name: ${_thname.text} surname: ${_thsurname.text}
                          //           title: $engValue name: ${_enname.text} surname: ${_ensurname.text}
                          //           email: ${_email.text}, mobile: ${_mobileno.text}, agreement: $isPersonalAgreementChecked""");
                          //       // Navigator.push(
                          //       //   context,
                          //       //   MaterialPageRoute(
                          //       //     builder: (context) {
                          //       //       // return const IDCardPage();
                          //       //       return IDCardPage(
                          //       //         preinfo: Preinfo(
                          //       //             thtitle: thValue!,
                          //       //             thname: _thname.text,
                          //       //             thsurname: _thsurname.text,
                          //       //             engtitle: engValue!,
                          //       //             engname: _enname.text,
                          //       //             engsurname: _ensurname.text,
                          //       //             email: _email.text,
                          //       //             mobile: _mobileno.text,
                          //       //             agreement:
                          //       //                 isPersonalAgreementChecked),
                          //       //       );
                          //       //     },
                          //       //   ),
                          //       // );
                          //     }
                          //   },
                          //   child: const Icon(
                          //     Icons.arrow_right_alt,
                          //     size: 30,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
    return Scaffold(body: body);
  }
}
