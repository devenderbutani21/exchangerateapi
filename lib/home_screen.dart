import 'package:flutter/material.dart';
import 'exchangeapi.dart';
import 'rate_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _valueController = TextEditingController();
  Future<Exchangevalue> exchangeValue;
  double _value = 0;
  String base = "GBP";
  String dropdownValue = "USD";
  List<String> curr1, curr2;

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
              curr1 = _exchangeValue.rates.keys.toList();
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
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
                              hintText: "Val",
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DropdownButton<String>(
                          value: base,
                          items: curr1.map((String value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              base = newValue;
                            });
                          },
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          items: curr1.map((String value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Material(
                      child: MaterialButton(
                        child: Text('Get Conversion'),
                        color: Colors.orangeAccent,
                        onPressed: () {
                          if(_valueController.text.isNotEmpty) {
                            setState(() {
                              _value = _exchangeValue.rates["${dropdownValue}"] *
                                  int.parse(_valueController.text);
                            });
                          }
                        },
                      ),
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
