import 'package:flutter/material.dart';
import 'package:ico_open/model/personal_info.dart';
import 'package:ico_open/misc/misc.dart' as misc;
import 'package:ico_open/model/model.dart' as model;

class AddressWidget extends StatefulWidget {
  AddressModel? address;
  AddressWidget({super.key, this.address});

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  Widget build(BuildContext context) {
    final homeNumberController = TextEditingController();
    bool homeNumberErrorCondition = false;
    final homenumber = misc.importantTextField(
        textController: homeNumberController,
        errorTextCondition: homeNumberErrorCondition,
        errorTextMessage: misc.thErrorMessage(model.homeNumberSubject),
        subject: model.homeNumberSubject,
        filterPattern: model.allfilter,
        onchangedFunction: (value) {
          setState(() {
            widget.address!.homenumber = value;
          });
        });

    return Column(children: [

       homenumber,
    ]);
  }
}
