import 'dart:async';

import 'package:cryptotracker_with_api/models/api.dart';
import 'package:cryptotracker_with_api/models/cryptocurrency.dart';
import 'package:cryptotracker_with_api/models/local_storage.dart';
import 'package:flutter/material.dart';

class MarketProvider with ChangeNotifier{
  bool isLoading = true;

  List<CryptoCurrency> markets = [];

  MarketProvider(){
    fetchData();
  }

  Future<void> fetchData()async{
    List<dynamic> _markets = await API.getMarkets();
    List<String> favorites = await LocalStorage.fetchFavorite();

    List<CryptoCurrency> temp = [];
    for(var market in _markets){
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);

      if(favorites.contains(newCrypto.id!)) {
        newCrypto.isFavorite = true;
      }
      temp.add(newCrypto);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();

    // Timer(const Duration(seconds: 2), (){
    //   fetchData();
    //   print("updated!");
    // });
  }
  
  CryptoCurrency fetchCryptoById(String id){
    CryptoCurrency crypto = markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFavorites(CryptoCurrency crypto)async{
    int indexCrypto = markets.indexOf(crypto);
    markets[indexCrypto].isFavorite =true;
    await LocalStorage.addFavorite(crypto.id!);
    notifyListeners();
  }

  void removeFavorites(CryptoCurrency crypto)async{
    int indexCrypto = markets.indexOf(crypto);
    markets[indexCrypto].isFavorite =false;
    await LocalStorage.removeFavorite(crypto.id!);
    notifyListeners();
  }
}