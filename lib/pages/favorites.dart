import 'package:cryptotracker_with_api/models/cryptocurrency.dart';
import 'package:cryptotracker_with_api/provider/market_provider.dart';
import 'package:cryptotracker_with_api/widgets/crypto_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
        builder:(context,marketProvider, child){
          
          List<CryptoCurrency> favorite = marketProvider.markets.where((element) =>
          element.isFavorite == true).toList();

          if (favorite.length > 0) {
            return ListView.builder(
                itemCount: favorite.length,
                itemBuilder: (context, index){
                  CryptoCurrency currentCurrency = favorite[index];
                  return CryptoListTile(currentCurrency: currentCurrency);
                }
            );
          }else{
            return Center(
              child: Text("No Favorites yet",style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),),
            );
          }


        }
    );
  }
}
