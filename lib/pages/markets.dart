import 'package:cryptotracker_with_api/models/cryptocurrency.dart';
import 'package:cryptotracker_with_api/widgets/crypto_list_tile.dart';
import 'package:cryptotracker_with_api/provider/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (BuildContext context, marketprovider, Widget? child) {
        if(marketprovider.isLoading == true){
          return Center(child: CircularProgressIndicator());
        }else{
          if(marketprovider.markets.length > 0){
            return RefreshIndicator(

              onRefresh: ()async {
                await marketprovider.fetchData();
              },
              child: ListView.builder(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: marketprovider.markets.length,
                  itemBuilder: (context, index){
                    CryptoCurrency currentCurrency = marketprovider.markets[index];
                    return CryptoListTile(currentCurrency: currentCurrency);
                  }
              ),
            );
          }else{
            return Text("Data Not Found");
          }
        }
      },
    );
  }
}
