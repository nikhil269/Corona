import 'dart:convert';

import 'package:corona/model/total.dart';
import 'package:http/http.dart' as http;

final String url = 'https://api.covid19india.org/data.json';

Future<String> getIndia() async {
  var response = await http.get(Uri.encodeFull(url));
}
