import 'dart:convert';

import 'package:http/http.dart' as http;
import 'rate_model.dart';

class ExchangeApi {
  Future<Exchangevalue> fetchExchangeValues() async {
    final response = await http.get('https://api.exchangeratesapi.io/latest?base=USD');
    if(response.statusCode == 200) {
      return Exchangevalue.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Exchange Values not found');
    }
  }


}