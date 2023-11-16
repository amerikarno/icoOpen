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
}

class BankAccountModel {
  BankAccountModel({
    required this.bankName,
    required this.bankAccountID,
  });
  final String bankName;
  String? bankBranchName;
  final String bankAccountID;
}

class OccupationModel {
  const OccupationModel({
    required this.sourceOfIncome,
    required this.currentOccupation,
    required this.officeName,
    required this.positionName,
    required this.typeOfBusiness,
    required this.salaryRange,
  });

  final String sourceOfIncome;
  final String currentOccupation;
  final String officeName;
  final String typeOfBusiness;
  final String positionName;
  final String salaryRange;
}
