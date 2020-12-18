import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'getExchangeButton.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'pickers.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String selectedCrypto = 'BTC';
  String selectFiat = '?';
  String selectCrypto = 'BTC';
  String targetURL = '$coinAPIURL/BTC/USD?apiKey=$apiKey';
  String requestCurrency = 'USD';
  String requestCrypto = 'BTC';
  String responseCurrency = '?';
  String responseCrypto = '?';
  String responseValue = '0.0';

  void onChangeCurrency(String value) {
    setState(() {
      requestCurrency = value;
    });
    targetURL = '$coinAPIURL/$requestCrypto/$requestCurrency?apiKey=$apiKey';
    print(targetURL);
  }

  void onChangeCrypto(String value) {
    setState(() {
      requestCrypto = value;
    });
    targetURL = '$coinAPIURL/$requestCrypto/$requestCurrency?apiKey=$apiKey';
    print(targetURL);
  }

//  12. Create a variable to hold the value and use in our Text Widget. Give the variable a starting value of '?' before the data comes back from the async methods.

  //11. Create an async method here await the coin data from coin_data.dart
  void getData(String newurl) async {
    try {
      double data = await CoinData().getCoinData(newurl);
      print(data);
      //13. We can't await in a setState(). So you have to separate it out into two steps.
      setState(() {
        responseValue = data.toStringAsFixed(0);
        responseCrypto = requestCrypto;
        responseCurrency = requestCurrency;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    //getData('https://rest.coinapi.io/v1/exchangerate/BTC/USD?apiKey=23181948-CE3E-4EBA-879A-2A79237DBBEE');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
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
                  //15. Update the Text Widget with the data in bitcoinValueInUSD.
                  '1 $responseCrypto = $responseValue $responseCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          GetExchangeWidget(
            horizontalInset: 20,
            onPressed: () => getData(targetURL),
            title:
                'Click to Convert ${cryptoDescription[requestCrypto]}($requestCrypto) to ${currencyDescription[requestCurrency]} ($requestCurrency)',
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS
                ? IosPicker(
                    itemList: cryptoList,
                    // 'onChange' calls 'onChangeCrypto' whenever
                    // the dropdown value changes
                    onChange: onChangeCrypto,
                  )
                : AndroidCurrencyDropdown(
                    selectedItem: requestCrypto,
                    itemList: cryptoList,
                    // 'onChange' calls 'onChangeCrypto' whenever
                    // the dropdown value changes
                    onChange: onChangeCrypto,
                  ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS
                ? IosPicker(
                    itemList: currenciesList,
                    // 'onChange' calls 'onChangeCurrency' whenever
                    // the dropdown value changes
                    onChange: onChangeCurrency,
                  )
                : AndroidCurrencyDropdown(
                    selectedItem: requestCurrency,
                    itemList: currenciesList,
                    // 'onChange' calls 'onChangeCurrency' whenever
                    // the dropdown value changes
                    onChange: onChangeCurrency,
                  ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
