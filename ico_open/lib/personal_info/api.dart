import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

// dynamic data;


Future<List<String>> getProvince() async {
List<String> provinces = [];

  final url = Uri(
    scheme: "http",
    host: "localhost",
    port: 1323,
    path: "api/v1/all_provinces",
  );
  log('start api to get provinces data...');
  final response = await http.get(url).timeout(const Duration(seconds: 1));
  final data = jsonDecode(response.body);
  log('status code: ${response.statusCode}');
  log('data: $data');
  if (response.statusCode == 200) {
    for (var i in data) {
      provinces.add(i);
    }
  }

  log('provinces: $provinces');
  log('end get provinces data, total: ${provinces.length} ');

  return provinces;
}

Future<List<String>> getAmphure(String? province) async {
  List<String> amphures = [];

  final url = Uri(
    scheme: "http",
    host: "localhost",
    port: 1323,
    path: "api/v1/amphures/$province",
  );
  log('start api to get amphures data...');
  final response = await http.get(url).timeout(const Duration(seconds: 1));
  final data = jsonDecode(response.body);
  log('status code: ${response.statusCode}');
  log('data: $data');
  if (response.statusCode == 200) {
    for (var i in data) {
      amphures.add(i);
    }
    log('amphures: $amphures');
    log('end get amphures data, total: ${amphures.length} ');
    return amphures;
  }

  return [];
}

Future<List<String>> getTambon(String? amphure) async {
List<String> tambons = [];

  final url = Uri(
    scheme: "http",
    host: "localhost",
    port: 1323,
    path: "api/v1/tambons/$amphure",
  );
  log('start api to get tambons data...');
  final response = await http.get(url).timeout(const Duration(seconds: 1));
  final data = jsonDecode(response.body);
  log('status code: ${response.statusCode}');
  log('data: $data');
  if (response.statusCode == 200) {
    for (var i in data) {
      tambons.add(i);
    }
    log('tambons: $tambons');
    log('end get tambons data, total: ${tambons.length} ');
    return tambons;
  }

  return [];
}

Future<String> getZipCode(String? zipname) async {
String? zipcode;

  final url = Uri(
    scheme: "http",
    host: "localhost",
    port: 1323,
    path: "api/v1/zipcode/$zipname",
  );
  log('start api to get zipcode data...$zipname');
  final response = await http.get(url).timeout(const Duration(seconds: 1));
  final data = jsonDecode(response.body);
  log('status code: ${response.statusCode}');
  log('data: $data');
  if (response.statusCode == 200) {
    zipcode = data.toString();
    log('zipcode: $zipcode');
    return zipcode;
  }

  return '';
}
