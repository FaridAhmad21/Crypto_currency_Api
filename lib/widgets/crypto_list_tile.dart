import 'package:cryptotracker_with_api/models/cryptocurrency.dart';
import 'package:cryptotracker_with_api/pages/details_page.dart';
import 'package:cryptotracker_with_api/provider/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {

  final CryptoCurrency currentCurrency ;

  const CryptoListTile({super.key, required this.currentCurrency});
  @override
  Widget build(BuildContext context) {
    MarketProvider marketprovider = Provider.of<MarketProvider>(context);
    return ListTile(
      onTap: (){
        Navigator.push(
            context, MaterialPageRoute(
            builder: (context) => DetailsPage(
              id: currentCurrency.id!,
            )));
      },
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCurrency.image!),
      ),
      title: Row(
        children: [
          Flexible(child: Text(currentCurrency.name!,overflow: TextOverflow.ellipsis, ),),
          Text("#${currentCurrency.marketCapRank}"),
          SizedBox(width: 5,),
          (currentCurrency.isFavorite == false) ? GestureDetector(
            onTap: (){
              marketprovider.addFavorites(currentCurrency);
            },
            child: Icon(CupertinoIcons.star,size: 15,),
          ) :
          GestureDetector(
            onTap: (){
              marketprovider.removeFavorites(currentCurrency);
            },
            child: Icon(CupertinoIcons.star_fill,size: 15,),
          ),
        ],
      ),
      subtitle: Text(currentCurrency.symbol!.toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("₨ " + currentCurrency.currentPrice!.toStringAsFixed(4),
            style: TextStyle(
                color: Color(0xff0395eb),
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),),
          Builder(
              builder: (context){
                double priceChange = currentCurrency.priceChange24!;
                double priceChangePercentage = currentCurrency.
                priceChangePercentage24!;
                if(priceChange < 0){
                  return Text("${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                      style: TextStyle(
                        color: Colors.red,
                      ));
                }else{
                  return Text("+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                      style: TextStyle(
                        color: Colors.green,
                      ));
                }
              }
          )
        ],
      ),
    );
  }
}
