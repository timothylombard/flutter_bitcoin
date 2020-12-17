import 'networking.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '23181948-CE3E-4EBA-879A-2A79237DBBEE';

// class MyCoinData {
//   MyCoinData(this.crypto, this.fiat)
//
//   Future<dynamic> getCryptoFiat(crypto, fiat) async {
//     NetworkHelper networkHelper = NetworkHelper('$coinAPIURL/$crypto/$fiat?apiKey=$apikey');
//
//     var coinData = await networkHelper.getData();
//     print(coinData);
//     return coinData;
//   }
//
//
//
// }

class CoinData {
  //3. Create the Asynchronous method getCoinData() that returns a Future (the price data).
  Future getCoinData(String fiat) async {
    //4. Create a url combining the coinAPIURL with the currencies we're interested, BTC to USD.
    String requestURL =fiat; //'$coinAPIURL/BTC/$fiat?apikey=$apiKey';
    //5. Make a GET request to the URL and wait for the response.
    http.Response response = await http.get(requestURL);

    //6. Check that the request was successful.
    if (response.statusCode == 200) {
      //7. Use the 'dart:convert' package to decode the JSON data that comes back from coinapi.io.
      var decodedData = jsonDecode(response.body);
      //8. Get the last price of bitcoin with the key 'last'.
      var lastPrice = decodedData['rate'];
      //9. Output the lastPrice from the method.
      return lastPrice;
    } else {
      //10. Handle any errors that occur during the request.
      print(response.statusCode);
      //Optional: throw an error if our request fails.
      throw 'Problem with the get request';
    }
  }
}


const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'XRP',
  'XLM',
  'XMR',
  'NEO',
  'ZEC',
  'ADA',
  'TRX',
  'ONT',
];

const Map currencyDescription = {
  'AUD': 'Australian Dollar',
  'BRL': 'Brazillian Real' ,
  'CAD':'Canadian Dollar',
  'CNY': 'Chinese Yuan',
  'EUR': 'Euro',
  'GBP': 'Great British Pound',
  'HKD': 'Hong Kong Dollar',
  'IDR': 'Indonesian Rupiah',
  'ILS': 'Israeli Shekel',
  'INR': 'Indian Rupee',
  'JPY': 'Japanese Yen',
  'MXN': 'Mexican Peso',
  'NOK': 'Norwegian Krone',
  'NZD': 'New Zealand Dollar',
  'PLN': 'Polish Zloty',
  'RON': 'Romanian New Leu',
  'RUB': 'Russian Ruble',
  'SEK': 'Swedish Krona',
  'SGD': 'Singapore Dollar',
  'USD': 'United States Dollar',
  'ZAR': 'South African Rand',
};

const Map cryptoDescription = {
  'BTC':'Bitcoin',
  'ETH':'Ethereum',
  'LTC':'Litecoin',
  'XRP': 'Ripple',
  'XLM': 'Stellar',
  'XMR': 'Monero',
  'NEO': 'Neo',
  'ZEC': 'Zcash',
  'ADA': 'Cardano',
  'TRX': 'Tron',
  'ONT': "Ontology",

};