import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  double? LRate;
  double? ERate;
  double? BRate;
  String? selectedCurrency = 'USD';
  String? currencyName = 'USD';
  @override
  void initState() {
    super.initState();
    getCurrency(
        selectedCurrency); // Call getCurrency() when the widget is first built
  }

  Future<dynamic> getCurrency(String? currency) async {
    String url1 =
        'https://rest.coinapi.io/v1/exchangerate/BTC/$currency?apikey=001FDF63-27A9-470D-9E1A-1AED03656922';
    String url2 =
        'https://rest.coinapi.io/v1/exchangerate/ETH/$currency?apikey=001FDF63-27A9-470D-9E1A-1AED03656922';
    String url3 =
        'https://rest.coinapi.io/v1/exchangerate/LTC/$currency?apikey=001FDF63-27A9-470D-9E1A-1AED03656922';

    http.Response response1 = await http.get(Uri.parse(url1));
    http.Response response2 = await http.get(Uri.parse(url2));
    http.Response response3 = await http.get(Uri.parse(url3));
    if (response1.statusCode == 200) {
      String data1 = response1.body;
      String data2 = response2.body;
      String data3 = response3.body;
      var decodeData1 = jsonDecode(data1);
      var decodeData2 = jsonDecode(data2);
      var decodeData3 = jsonDecode(data3);
      setState(() {
        currencyName = decodeData1['asset_id_quote'];
        BRate = decodeData1['rate'];
        ERate = decodeData2['rate'];
        LRate = decodeData3['rate'];
        // Update inside setState
      });
      BRate = decodeData1['rate'];
      ERate = decodeData2['rate'];
      LRate = decodeData3['rate'];
      return decodeData1;
    } else {
      print(response1.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  BRate != null
                      ? '1 BTC = ${BRate!.toStringAsFixed(2)} $currencyName'
                      : 'Loading...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  ERate != null
                      ? '1 ETH = ${ERate!.toStringAsFixed(2)} $currencyName'
                      : 'Loading...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  LRate != null
                      ? '1 LTC = ${LRate!.toStringAsFixed(2)} $currencyName'
                      : 'Loading...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
                value: selectedCurrency,
                items: [
                  for (String currency in currenciesList)
                    DropdownMenuItem(
                      child: Text(currency),
                      value: currency,
                    ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value;
                    getCurrency(value);
                  });
                }),
          ),
        ],
      ),
    );
  }
}
