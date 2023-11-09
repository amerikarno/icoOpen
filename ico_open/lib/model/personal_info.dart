
class PersonalInformation {
  PersonalInformation({
    required this.registeredAddress,
  });

  final Address registeredAddress;
  Address? currentAddress;
  Address? officeAddress;
  BankAccount? bankAccount;
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
  BankAccount({
    required this.bankName,
    required this.bankAccountID,
  });
  final String bankName;
  String? bankBranchName;
  final String bankAccountID;
}