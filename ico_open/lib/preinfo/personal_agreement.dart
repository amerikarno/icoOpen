import 'package:flutter/material.dart';
import 'package:ico_open/model/personal_agreement.dart';

  bool isPersonalAgreementChecked = false;

class CheckboxPersonalAggreement extends StatefulWidget {
  const CheckboxPersonalAggreement({super.key});

  @override
  State<CheckboxPersonalAggreement> createState() =>
      _CheckboxPersonalAggreementState();
}

class _CheckboxPersonalAggreementState
    extends State<CheckboxPersonalAggreement> {

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      if (isPersonalAgreementChecked) {
        return Colors.blue;
      }
      return Colors.grey;
    }

    return CheckboxListTile(
      // title: const Text("""ข้าพเจ้าได้อ่านและตกลงตามข้อมกำหนดและเงื่อนไขและรับทราบนโยบายความเป็นส่วนตัว ซึ่งระบุวิธีการที่บริษัท ฟินันเซีย ดิจิตทัล แอสแซท จำกัด(
      //   "บริษัท"
      // )""", maxLines: 2,overflow: TextOverflow.ellipsis,),
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isPersonalAgreementChecked,
      onChanged: (bool? value) {
        setState(() {
          isPersonalAgreementChecked = value!;
        });
      },
    );
  }
}

class PersonalAgreement extends StatelessWidget {
  const PersonalAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('นโยบายความเป็นส่วนตัว'),
          content: SizedBox(
            width: (MediaQuery.of(context).size.width * 0.6),
            child: const SingleChildScrollView(
              padding: EdgeInsetsDirectional.all(15),
              child: Text(agreement),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const IDCardPage();
                //     },
                //   ),
                // );
              },
              child: const Text(
                'OK',
              ),
            ),
          ],
        ),
      ),
      child: const Text('อ่านรายละเอียดเพิ่มเติม'),
    );
  }
}
