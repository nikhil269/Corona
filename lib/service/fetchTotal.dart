import 'dart:convert';

import 'package:corona/model/total.dart';
import 'package:http/http.dart' as http;

Future<Total> fetchTotal() async {
  final response = await http.get('https://corona.lmao.ninja/v2/all');

  if (response.statusCode == 200) {
    return Total.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load Total');
  }
}
