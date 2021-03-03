// To parse this JSON data, do
//
//     final exchangevalue = exchangevalueFromJson(jsonString);

import 'dart:convert';

Exchangevalue exchangevalueFromJson(String str) => Exchangevalue.fromJson(json.decode(str));

String exchangevalueToJson(Exchangevalue data) => json.encode(data.toJson());

class Exchangevalue {
  Exchangevalue({
    this.rates,
    this.base,
    this.date,
  });

  Map<String, double> rates;
  String base;
  DateTime date;

  factory Exchangevalue.fromJson(Map<String, dynamic> json) => Exchangevalue(
    rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
    base: json["base"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "base": base,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}
