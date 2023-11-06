import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

List<String> provinces = [];
List<String> districts = [];
dynamic data;
void getZipCode() async {
  final url = Uri(
    scheme: "https",
    host: "raw.githubusercontent.com",
    path:
        "kongvut/thai-province-data/master/api_province_with_amphure_tambon.json",
  );
  log('start api to get provinces data...');
  final response = await http.get(url).timeout(const Duration(seconds: 1));
  final data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    for (var i in data) {
      log(i['name_th']);
      provinces.add(i['name_th']);
    }
  }

  log(provinces.toString());
  log('end get provinces data, total: ${provinces.length} ');
}

void getDistrict(String province) {
  for (var i in data[0]['amphure']) {
    districts.add(i);
  }

  log(districts.toString());
}