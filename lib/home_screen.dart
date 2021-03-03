import 'package:flutter/material.dart';
import 'exchangeapi.dart';
import 'rate_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future <Exchangevalue> exchangeValue;

  @override
  void initState() {
    exchangeValue = ExchangeApi().fetchExchangeValues();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Container(
        color: Colors.red,
        child: Text(exchangeValue.toString()),
      ),
    );
  }
}

