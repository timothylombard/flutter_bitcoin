import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;


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

  DropdownButton<String> androidCurrencyDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  DropdownButton<String> androidCryptoDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String crypto in cryptoList) {
      var newItem = DropdownMenuItem(
        child: Text(crypto),
        value: crypto,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCrypto,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  CupertinoPicker iOSCurrencyPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      useMagnifier:true,
      magnification: 1.5,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        String selectedFiat = currenciesList[selectedIndex];
        print(selectedFiat);
        fiatValue = selectedFiat;
        setState(() {
          selectFiat = selectedFiat;
        });
        targetURL = '$coinAPIURL/$selectCrypto/$selectFiat?apiKey=$apiKey';
        print(targetURL);
        //getData(coinUrl);

      },
      children: pickerItems,
    );
  }

  CupertinoPicker iOSCryptoPicker() {
    List<Text> pickerItems = [];
    for (String crypto in cryptoList) {
      pickerItems.add(Text(crypto));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 30.0,
      useMagnifier:true,
      magnification: 1.25,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        String selectedCrypto = cryptoList[selectedIndex];
        print(selectedCrypto);
        //String cryptoValue = selectedCrypto;
        setState(() {
          selectCrypto = selectedCrypto;
        });
        targetURL = '$coinAPIURL/$selectCrypto/$selectFiat?apiKey=$apiKey';
        print(targetURL);
        //getData(coinUrl);

      },
      children: pickerItems,
    );
  }

  //12. Create a variable to hold the value and use in our Text Widget. Give the variable a starting value of '?' before the data comes back from the async methods.
  String bitcoinValueInUSD = '?';
  String fiatValue = 'USD';

  //11. Create an async method here await the coin data from coin_data.dart
  void getData(String newurl) async {
    try {
      double data = await CoinData().getCoinData(newurl);
      print(data);
      //13. We can't await in a setState(). So you have to separate it out into two steps.
      setState(() {
        bitcoinValueInUSD = data.toStringAsFixed(0);
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
                  '1 BTC = $bitcoinValueInUSD USD',
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
                  //15. Update the Text Widget with the data in bitcoinValueInUSD.
                  'Convert $selectCrypto to $selectFiat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 200,),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSCurrencyPicker() : androidCurrencyDropdown()
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSCryptoPicker() : androidCryptoDropdown()
          ),
          SizedBox(height: 100,)
        ],
      ),
    );
  }
}

