import 'dart:convert';

import 'package:http/http.dart'as http;

class API{

  static Future<List<dynamic>> getMarkets()async{
    try{
      Uri requestPath = Uri.parse("https://api.coingecko.com/api/v3/coins/markets?"
          "vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false");
      var response = await http.get(requestPath);
      var decodeResponse =  jsonDecode(response.body);

      List<dynamic> markets = decodeResponse as List<dynamic>;
      return markets;
    }catch(e){
      return [];
    }

  }
}
