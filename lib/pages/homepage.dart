import 'package:cryptotracker_with_api/models/cryptocurrency.dart';
import 'package:cryptotracker_with_api/pages/details_page.dart';
import 'package:cryptotracker_with_api/pages/favorites.dart';
import 'package:cryptotracker_with_api/pages/markets.dart';
import 'package:cryptotracker_with_api/provider/market_provider.dart';
import 'package:cryptotracker_with_api/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  
  late TabController getTabController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTabController = TabController(length: 2, vsync: this);
  }
  
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context,listen: true);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const Text("Welcome Back", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Crypto Today", style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  IconButton(

                      onPressed: (){
                        themeProvider.toogleTheme();
                      },
                      padding: EdgeInsets.all(0),
                      icon: (themeProvider.themeMode == ThemeMode.light) ? Icon(Icons.dark_mode)
                      : Icon(Icons.light_mode),

                  ),
                ],
              ),

              TabBar(
                controller: getTabController,
                  tabs: [
                    Tab(
                      child: Text("Markets", style:
                      Theme.of(context).textTheme.bodyText1,),
                    ),
                    Tab(
                      child: Text("Favorites", style:
                      Theme.of(context).textTheme.bodyText1,),
                    ),
                  ]),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()
                  ),
                  controller: getTabController,
                    children: [
                      Markets(),

                      Favorites(),

                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
