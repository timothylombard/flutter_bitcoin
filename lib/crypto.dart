
import 'networking.dart';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '23181948-CE3E-4EBA-879A-2A79237DBBEE';

class CryptoModel {
  Future<dynamic> getCryptoFiat(String crypto, String fiat) async {
    NetworkHelper networkHelper = NetworkHelper('$coinAPIURL/$crypto/$fiat?apikey=$apiKey');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }



  }
