import 'package:flutter/material.dart';

class PersonalInformationModel {
  PersonalInformationModel({
    required this.registeredAddress,
    required this.occupation,
  });

  final AddressModel registeredAddress;
  final OccupationModel occupation;
  AddressModel? currentAddress;
  AddressModel? officeAddress;
  BankAccountModel? bankAccount;
}

class AddressModel {
  AddressModel({
    required this.homenumber,
    // required this.subDistrictName,
    required this.zipcode,
    required this.countryName,
    required this.typeOfAddress,
    required this.condition,
  });

  String homenumber;
  String? villageNumber;
  String? villageName;
  String? subStreetName;
  String? streetName;
  String? subDistrictName;
  String? districtName;
  String? provinceName;
  int zipcode;
  String countryName;
  String typeOfAddress;
  Condition condition;
}

class BankAccountModel {
  BankAccountModel({
    required this.bankName,
    required this.bankAccountID,
    required this.serviceType,
  });
  String bankName;
  String? bankBranchName;
  String bankAccountID;
  final String serviceType;
}

class OccupationModel {
  OccupationModel({
    required this.sourceOfIncome,
    required this.currentOccupation,
    required this.officeName,
    required this.positionName,
    required this.typeOfBusiness,
    required this.salaryRange,
  });

  String sourceOfIncome;
  String currentOccupation;
  String officeName;
  String typeOfBusiness;
  String positionName;
  String salaryRange;
}

class Condition {
  Condition({
    required this.homenumber,
    required this.subdistrict,
    required this.district,
    required this.province,
    required this.zipcode,
    required this.country,
  });
  bool homenumber;
  bool subdistrict;
  bool district;
  bool province;
  bool zipcode;
  bool country;
}
