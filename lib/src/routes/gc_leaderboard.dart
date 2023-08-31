import 'dart:collection';

import 'package:InstiApp/src/api/model/event.dart';
import 'package:InstiApp/src/bloc_provider.dart';
import 'package:InstiApp/src/blocs/ia_bloc.dart';
import 'package:InstiApp/src/drawer.dart';
import 'package:InstiApp/src/routes/eventpage.dart';
import 'package:InstiApp/src/routes/explorepage.dart';
import 'package:InstiApp/src/routes/feedpage.dart';
import 'package:InstiApp/src/utils/common_widgets.dart';
import 'package:InstiApp/src/utils/title_with_backbutton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

final List<String> initial = [
  'Overall',
  'Culturals GC',
  'Sports GC',
  'Tech GC',
];

final Map<String, List<String>> ranking = {
  'Overall': [
    "Hostel6",
    "Hostel4",
    "Hostel7",
    "Hostel3",
    "Hostel1",
    "Hostel5",
    "Hostel10",
    "Hostel11",
    "Hostel2",
    "Hostel13",
    "Hostel9",
    "Hostel8",
    "Hostel12",
    "Hostel14",
    "Tansa"
  ],
  'Culturals GC': [
    "Hostel6",
    "Hostel7",
    "Hostel4",
    "Hostel3",
    "Hostel1",
    "Hostel5",
    "Hostel10",
    "Hostel11",
    "Hostel2",
    "Hostel13",
    "Hostel9",
    "Hostel8",
    "Hostel12",
    "Hostel14",
    "Tansa"
  ],
  'Sports GC': [
    "Hostel4",
    "Hostel6",
    "Hostel12",
    "Hostel10",
    "Hostel7",
    "Hostel9",
    "Hostel2",
    "Hostel13",
    "Hostel1",
    "Hostel11",
    "Hostel8",
    "Hostel3",
    "Hostel14",
    "Tansa",
    "Hostel5"
  ],
  'Tech GC': [
    "Hostel11",
    "Hostel3",
    "Hostel5",
    "Hostel2",
    "Hostel9",
    "Hostel7",
    "Hostel8",
    "Hostel13",
    "Hostel1",
    "Hostel6",
    "Hostel14",
    "Hostel12",
    "Tansa",
    "Hostel10",
    "Hostel4"
  ],
};

final Map<String, List<String>> differentGCs = {
  'Culturals GC': ['Dance GC', 'Music GC', 'Dramatics GC'],
  'Sports GC': ['Football GC', 'Chess GC', 'Basketball GC'],
  'Tech GC': ['Bot GC', 'Drone GC', 'Race GC'],
};

final Map<String, List<String>> GCranking ={

  'Football GC': [
    "Hostel6",
    "Hostel4",
    "Hostel7",
    "Hostel3",
    "Hostel1",
    "Hostel5",
    "Hostel10",
    "Hostel11",
    "Hostel2",
    "Hostel13",
    "Hostel9",
    "Hostel8",
    "Hostel12",
    "Hostel14",
    "Tansa"
  ],
  'Race GC': [
    "Hostel6",
    "Hostel7",
    "Hostel4",
    "Hostel3",
    "Hostel1",
    "Hostel5",
    "Hostel10",
    "Hostel11",
    "Hostel2",
    "Hostel13",
    "Hostel9",
    "Hostel8",
    "Hostel12",
    "Hostel14",
    "Tansa"
  ],
  'Drone GC': [
    "Hostel4",
    "Hostel6",
    "Hostel12",
    "Hostel10",
    "Hostel7",
    "Hostel9",
    "Hostel2",
    "Hostel13",
    "Hostel1",
    "Hostel11",
    "Hostel8",
    "Hostel3",
    "Hostel14",
    "Tansa",
    "Hostel5"
  ],
  'Bot GC': [
    "Hostel11",
    "Hostel3",
    "Hostel5",
    "Hostel2",
    "Hostel9",
    "Hostel7",
    "Hostel8",
    "Hostel13",
    "Hostel1",
    "Hostel6",
    "Hostel14",
    "Hostel12",
    "Tansa",
    "Hostel10",
    "Hostel4"
  ],

  'Dramatics GC': [
    "Hostel6",
    "Hostel4",
    "Hostel7",
    "Hostel3",
    "Hostel1",
    "Hostel5",
    "Hostel10",
    "Hostel11",
    "Hostel2",
    "Hostel13",
    "Hostel9",
    "Hostel8",
    "Hostel12",
    "Hostel14",
    "Tansa"
  ],
  'Chess GC': [
    "Hostel6",
    "Hostel7",
    "Hostel4",
    "Hostel3",
    "Hostel1",
    "Hostel5",
    "Hostel10",
    "Hostel11",
    "Hostel2",
    "Hostel13",
    "Hostel9",
    "Hostel8",
    "Hostel12",
    "Hostel14",
    "Tansa"
  ],
  'Basketball GC': [
    "Hostel4",
    "Hostel6",
    "Hostel12",
    "Hostel10",
    "Hostel7",
    "Hostel9",
    "Hostel2",
    "Hostel13",
    "Hostel1",
    "Hostel11",
    "Hostel8",
    "Hostel3",
    "Hostel14",
    "Tansa",
    "Hostel5"
  ],
  'Chess GC': [
    "Hostel11",
    "Hostel3",
    "Hostel5",
    "Hostel2",
    "Hostel9",
    "Hostel7",
    "Hostel8",
    "Hostel13",
    "Hostel1",
    "Hostel6",
    "Hostel14",
    "Hostel12",
    "Tansa",
    "Hostel10",
    "Hostel4"
  ],

  'Dance GC': [
    "Hostel4",
    "Hostel6",
    "Hostel12",
    "Hostel10",
    "Hostel7",
    "Hostel9",
    "Hostel2",
    "Hostel13",
    "Hostel1",
    "Hostel11",
    "Hostel8",
    "Hostel3",
    "Hostel14",
    "Tansa",
    "Hostel5"
  ],
  'Music GC': [
    "Hostel11",
    "Hostel3",
    "Hostel5",
    "Hostel2",
    "Hostel9",
    "Hostel7",
    "Hostel8",
    "Hostel13",
    "Hostel1",
    "Hostel6",
    "Hostel14",
    "Hostel12",
    "Tansa",
    "Hostel10",
    "Hostel4"
  ],

};

final List<String> items = initial;





class gcl_cards extends StatefulWidget {
  @override
  State<gcl_cards> createState() => _gcl_cardsState();

}

class _gcl_cardsState extends State<gcl_cards> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      bottomNavigationBar: MyBottomAppBar(
        shape: RoundedNotchedRectangle(),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              tooltip: "Show bottom sheet",
              icon: Icon(
                Icons.menu_outlined,
                semanticLabel: "Show bottom sheet",
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                "GC Leaderboard",
                style: theme.textTheme.headline3,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final gcName = items[index];
                    final gcRanking = ranking[gcName] ?? [];
                    final gcCompetitions = differentGCs[gcName] ?? [];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GCRankings(
                              gcName: gcName,
                              gcRanking: gcRanking,
                              gcCompetitions: gcCompetitions,
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Image.asset(
                          'assets/buynsell/DevcomLogo.png',
                          fit: BoxFit.fill,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(gcName, style: theme.textTheme.headline5),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class GCRankings extends StatefulWidget {
  final String gcName;
  final List<String> gcRanking;
  final List<String> gcCompetitions;

  GCRankings({required this.gcName, required this.gcRanking,required this.gcCompetitions});

  @override
  State<GCRankings> createState() => _GCRankingsState();
}

class _GCRankingsState extends State<GCRankings> with TickerProviderStateMixin{
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    if(widget.gcName == 'Overall'){return Scaffold(      key: _scaffoldKey,
        drawer: NavDrawer(),
        bottomNavigationBar: MyBottomAppBar(
          shape: RoundedNotchedRectangle(),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                tooltip: "Show bottom sheet",
                icon: Icon(
                  Icons.menu_outlined,
                  semanticLabel: "Show bottom sheet",
                ),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  '${widget.gcName}',
                  style: theme.textTheme.headline3,
                ),
              ),

              Expanded(
                  child: TabBarView(controller: _tabController,
                      children: [ListView.builder(
                        itemCount: widget.gcRanking.length,
                        itemBuilder: (context, index) {
                          final rankingItem = widget.gcRanking[index];
                          int itemNumber = index + 1;
                          return ListTile(
                            title: Row(
                              children: [
                                Text('$itemNumber. ', style: theme.textTheme.bodyText1),
                                Image.asset(
                                  'assets/buynsell/DevcomLogo.png',
                                  fit: BoxFit.fill,height: 60,width: 60,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(rankingItem, style: theme.textTheme.bodyLarge),
                                ),
                              ],
                            ),
                          );
                        },
                      ),ListView.builder(
                        itemCount: widget.gcCompetitions.length,
                        itemBuilder: (context, index) {
                          final String rankingItem = widget.gcCompetitions[index];


                          return ListTile(
                            title: InkWell(onTap: (){Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => particular_gc(gcname: rankingItem,Ranking: GCranking[rankingItem] ?? [],)
                              ),);},
                              child: Row(
                                children: [Spacer(),


                                  Text(rankingItem, style: theme.textTheme.headline5),Spacer(),Column(
                                    children: [
                                      Image.asset(
                                        'assets/buynsell/DevcomLogo.png',
                                        fit: BoxFit.fill,height: 80,width: 80,
                                      ),Text("Hostel 1")
                                    ],
                                  ),Spacer(),Column(
                                    children: [
                                      Image.asset(
                                        'assets/buynsell/DevcomLogo.png',
                                        fit: BoxFit.fill,height: 80,width: 80,
                                      ),Text("Hostel 3")
                                    ],
                                  ),Spacer(),Column(
                                    children: [
                                      Image.asset(
                                        'assets/buynsell/DevcomLogo.png',
                                        fit: BoxFit.fill,height: 80,width: 80,
                                      ),Text("Hostel 16")
                                    ],
                                  ),Spacer()
                                ],
                              ),
                            ),
                          );
                        },
                      ),]
                  )

              )
            ],
          ),
        ),);}
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      bottomNavigationBar: MyBottomAppBar(
        shape: RoundedNotchedRectangle(),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              tooltip: "Show bottom sheet",
              icon: Icon(
                Icons.menu_outlined,
                semanticLabel: "Show bottom sheet",
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                '${widget.gcName}',
                style: theme.textTheme.headline3,
              ),
            ),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(
                    "Rankings",
                    style: theme.textTheme.headline6,
                  ),
                ),

                Tab(
                  child: Text(
                    "Competitions",
                    style: theme.textTheme.headline6,
                  ),
                ),

              ],
            ),
            
            Expanded(
              child: TabBarView(controller: _tabController,
                children: [ListView.builder(
                  itemCount: widget.gcRanking.length,
                  itemBuilder: (context, index) {
                    final rankingItem = widget.gcRanking[index];
                    int itemNumber = index + 1;
                    return ListTile(
                      title: Row(
                        children: [
                          Text('$itemNumber. ', style: theme.textTheme.bodyText1),
                          Image.asset(
                            'assets/buynsell/DevcomLogo.png',
                            fit: BoxFit.fill,height: 50,width: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(rankingItem, style: theme.textTheme.bodyLarge),
                          ),
                        ],
                      ),
                    );
                  },
                ),ListView.builder(
                  itemCount: widget.gcCompetitions.length,
                  itemBuilder: (context, index) {
                    final rankingItem = widget.gcCompetitions[index];


                    return ListTile(
                      title: InkWell(onTap: (){Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => particular_gc(gcname: rankingItem,Ranking: GCranking[rankingItem] ?? [],)
                          ),);},
                        child: Row(
                          children: [Spacer(),


                            Text(rankingItem, style: theme.textTheme.titleMedium),Spacer(),Column(
                              children: [
                                Image.asset(
                                  'assets/buynsell/DevcomLogo.png',
                                  fit: BoxFit.fill,height: 40,width: 40,
                                ),Text(GCranking[rankingItem]![0].toString(),style: theme.textTheme.bodySmall)
                              ],
                            ),Spacer(),Column(
                              children: [
                                Image.asset(
                                  'assets/buynsell/DevcomLogo.png',
                                  fit: BoxFit.fill,height: 40,width: 40,
                                ),Text(GCranking[rankingItem]![1].toString(),style: theme.textTheme.bodySmall)
                              ],
                            ),Spacer(),Column(
                              children: [
                                Image.asset(
                                  'assets/buynsell/DevcomLogo.png',
                                  fit: BoxFit.fill,height: 40,width: 40,
                                ),Text(GCranking[rankingItem]![2].toString(),style: theme.textTheme.bodySmall)
                              ],
                            ),Spacer()
                          ],
                        ),
                      ),
                    );
                  },
                ),]
              )

            )
          ],
        ),
      ),
    );
  }
}



class particular_gc extends StatefulWidget {

  final String gcname;
  final List<String> Ranking;

  @override
  particular_gc({required this.gcname, required this.Ranking});
  State<particular_gc> createState() => _particular_gcState();
}

class _particular_gcState extends State<particular_gc> {
  @override

  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(body: SafeArea(
      child: Column(children: [Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(widget.gcname,style: theme.textTheme.headline3,),
      ),Expanded(
        child: ListView.builder(
            itemCount: widget.Ranking.length,
            itemBuilder: (context, index) {
              final hostelName = widget.Ranking[index];
              final hostelPoints = widget.Ranking[index];
              int itemnumber = index+1;

              return ListTile(

                title: Row(
                  children: [
                    Text('$itemnumber. ', style: theme.textTheme.bodyText1),
                    Image.asset(
                      'assets/buynsell/DevcomLogo.png',
                      fit: BoxFit.fill,height: 50,width: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(hostelName, style: theme.textTheme.bodyLarge),


                    ),Spacer(),IconButton(onPressed: (){}, icon: Icon(Icons.expand_less_rounded),iconSize: 20,color: Colors.green,),Spacer(),
                    Text((11-itemnumber).toString(), style: theme.textTheme.titleMedium),Spacer(),IconButton(onPressed: (){}, icon: Icon(Icons.expand_more_rounded),iconSize: 20,color: Colors.red,),Spacer(),
                  ],
                ),
              );
            }),
      ),],),
    ),);
  }
}

