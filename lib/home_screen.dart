import 'package:flutter/material.dart';
import 'exchangeapi.dart';
import 'rate_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _valueController = TextEditingController();
  TextEditingController _conversionController = TextEditingController();
  TextEditingController _conversionController2 = TextEditingController();
  Future<Exchangevalue> exchangeValue;
  String myText = "";
  String dropdownValue = 'One';
  double _value = 0;
  String base = "USD";

  @override
  void initState() {
    exchangeValue = ExchangeApi().fetchExchangeValues(base);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        color: Colors.white,
        child: FutureBuilder<Exchangevalue>(
          future: ExchangeApi().fetchExchangeValues(base),
          builder:
              (BuildContext context, AsyncSnapshot<Exchangevalue> snapshot) {
            if (snapshot.hasData) {
              Exchangevalue _exchangeValue = snapshot.data;
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: TextField(
                            controller: _valueController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintText: "Value",
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          child: TextField(
                            controller: _conversionController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintText: "Currency 1",
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          child: TextField(
                            controller: _conversionController2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintText: "Currency 2",
                            ),
                          ),
                        ),
                      ],
                    ),
                    MaterialButton(
                      child: Text('Get Conversion'),
                      color: Colors.orangeAccent,
                      onPressed: () {
                        setState(() {
                          base = _conversionController2.text;
                          myText = _conversionController.text;
                          _value = _exchangeValue.rates["${myText}"] *
                              int.parse(_valueController.text);
                        });
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text('${_value}'),
                  ],
                ),
              );
            } else if (!snapshot.hasData) {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
