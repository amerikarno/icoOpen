import 'package:flutter/material.dart';

class PersonalInformation {
  final Address registeredAddress;
  Address? currentAddress;
  Address? officeAddress;
}

class Address {
  Address({
    required this.houseNumber,
    required this.subDistrictName,
    required this.districtName,
    required this.provinceName,
    required this.zipcode,
    required this.countryName,
  });

  final String houseNumber;
  String? villageNumber;
  String? villageName;
  String? subStreetName;
  String? streetName;
  final String subDistrictName;
  final String districtName;
  final String provinceName;
  final int zipcode;
  final String countryName;
}

class BankAccount {
  final String BankName;
}