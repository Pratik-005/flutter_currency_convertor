import 'dart:convert';
import 'package:currency_converter/models/all_currencies.dart';
import 'package:currency_converter/models/rate_model.dart';
import 'package:currency_converter/utils/key.dart';
import 'package:http/http.dart' as http;

Future<Map<String, double>> fetchRates() async {
  var res = await http.get(
    Uri.parse(
      'https://openexchangerates.org/api/latest.json?base=USD&app_id=$key',
    ),
  );

  final result = RatesModel.fromJson(json.decode(res.body)).getRates;

  return result;
}

Future<Map> fetchcurrencies() async {
  var response = await http.get(
    Uri.parse('https://openexchangerates.org/api/currencies.json?app_id=$key'),
  );
  final allCurrencies = allCurrenciesFromJson(response.body);
  return allCurrencies;
}
