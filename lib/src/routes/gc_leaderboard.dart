import 'package:InstiApp/src/api/model/gcLeaderboard.dart';
import 'package:InstiApp/src/bloc_provider.dart';
import 'package:InstiApp/src/blocs/buynsell_post_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:InstiApp/src/drawer.dart';
import 'package:InstiApp/src/utils/common_widgets.dart';
import '../api/model/user.dart';
import 'package:InstiApp/src/blocs/gcLeaderboard_bloc.dart';

final List<GCType> initial = [
  GCType.Overall,
  GCType.Cult,
  GCType.Sports,
  GCType.Tech,
];

final List<String> hostels = [
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

final Map<String, List<String>> GCranking = {
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

//GC Cards for type iof GCs

class gcl_cards extends StatefulWidget {
  @override
  State<gcl_cards> createState() => _gcl_cardsState();
}

class _gcl_cardsState extends State<gcl_cards> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    GCbloc GCBloc = BlocProvider.of(context)!.bloc.gcbloc;

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
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add_outlined),
        label: Text(" Add GC "),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddGC()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
                itemCount: initial.length,
                itemBuilder: (context, index) {
                  final gcName = initial[index];
                  final gcCompetitions = differentGCs[gcName] ?? [];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GCRankings(
                            gcName: gcName,
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
                        child: Text(gcName.toString().substring(7),
                            style: theme.textTheme.headline5),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GCRankings extends StatefulWidget {
  final GCType gcName;
  final List<String> gcCompetitions;

  GCRankings({
    required this.gcName,
    required this.gcCompetitions,
  });

  @override
  State<GCRankings> createState() => _GCRankingsState();
}

class _GCRankingsState extends State<GCRankings> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late TabController _tabController;
  bool firstBuild = true;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    var GCBloc = BlocProvider.of(context)!.bloc.gcbloc;

    if (firstBuild) {
      GCBloc.refresh(widget.gcName).then(
        (value) {
          setState(
            () {
              loading = false;
            },
          );
        },
      );
    }

    if (widget.gcName == GCType.Overall) {
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
                  '${widget.gcName.toString().substring(7)}',
                  style: theme.textTheme.headline3,
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await GCBloc.refresh(widget.gcName);
                  },
                  child: StreamBuilder<List<GCHostelPoints>>(
                    stream: GCBloc.gcPosts,
                    builder: (context,
                        AsyncSnapshot<List<GCHostelPoints>> snapshot) {
                      if (!snapshot.hasData)
                        return CircularProgressIndicatorExtended();
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final GCHostelPoints rankingItem =
                              snapshot.data![index];
                          int itemNumber = index + 1;
                          return ListTile(
                            title: Row(
                              children: [
                                SizedBox(
                                  width: width * 1 / 8,
                                  child: Center(
                                    child: Text('$itemNumber. ',
                                        style: theme.textTheme.bodyText1),
                                  ),
                                ),
                                Image.asset(
                                  'assets/buynsell/DevcomLogo.png',
                                  fit: BoxFit.fill,
                                  height: 60,
                                  width: 60,
                                ),
                                SizedBox(
                                    width:
                                        8), // Add spacing between image and name
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: FittedBox(
                                    child: SizedBox(
                                      child: Text(
                                          rankingItem.hostel?.name ?? "Blank",
                                          style: theme.textTheme.bodyLarge),
                                      width: width * 2 / 8,
                                    ),
                                  ),
                                ),

                                FittedBox(
                                  child: SizedBox(
                                    child: Center(
                                      child: Text(
                                          rankingItem.points?.toString() ?? "",
                                          style: theme.textTheme.titleMedium),
                                    ),
                                    width: width * 1 / 8,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
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
                '${widget.gcName.toString().substring(7)}',
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
              child: TabBarView(
                controller: _tabController,
                children: [
                  StreamBuilder<List<GCHostelPoints>>(
                    stream: GCBloc.gcPosts,
                    builder: (context,
                        AsyncSnapshot<List<GCHostelPoints>> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicatorExtended();
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final rankingItem = snapshot.data![index];
                          int itemNumber = index + 1;
                          return ListTile(
                            title: Row(
                              children: [
                                SizedBox(
                                    width: width * 1 / 8,
                                    child: Center(
                                      child: Text('$itemNumber. ',
                                          style: theme.textTheme.bodyText1),
                                    )),
                                Image.asset(
                                  'assets/buynsell/DevcomLogo.png',
                                  fit: BoxFit.fill,
                                  height: 60,
                                  width: 60,
                                ),
                                SizedBox(
                                    width:
                                        8), // Add spacing between image and name
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: FittedBox(
                                      child: SizedBox(
                                    child: Text(rankingItem.hostel?.name ?? "",
                                        style: theme.textTheme.bodyLarge),
                                    width: width * 2 / 8,
                                  )),
                                ),

                                FittedBox(
                                    child: SizedBox(
                                  child: Center(
                                      child: Text(rankingItem.points.toString(),
                                          style: theme.textTheme.titleMedium)),
                                  width: width * 1 / 8,
                                )),
                                Spacer(),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: widget.gcCompetitions.length,
                    itemBuilder: (context, index) {
                      final rankingItem = widget.gcCompetitions[index];

                      return ListTile(
                        title: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => particular_gc(
                                        gcname: rankingItem,
                                        Ranking: GCranking[rankingItem] ?? [],
                                      )),
                            );
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  SizedBox(
                                      width: width / 3,
                                      child: Text(rankingItem,
                                          style: theme.textTheme.headline6)),
                                  Spacer(),
                                  SizedBox(
                                    width: width / 6,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/buynsell/DevcomLogo.png',
                                          fit: BoxFit.fill,
                                          height: 60,
                                          width: 60,
                                        ),
                                        FittedBox(
                                          child: Text(
                                              GCranking[rankingItem]![0]
                                                  .toString(),
                                              style: theme.textTheme.bodyLarge),
                                        )
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: width / 6,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/buynsell/DevcomLogo.png',
                                          fit: BoxFit.fill,
                                          height: 60,
                                          width: 60,
                                        ),
                                        FittedBox(
                                          child: Text(
                                              GCranking[rankingItem]![1]
                                                  .toString(),
                                              style: theme.textTheme.bodyLarge),
                                        )
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: width / 6,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/buynsell/DevcomLogo.png',
                                          fit: BoxFit.fill,
                                          height: 60,
                                          width: 60,
                                        ),
                                        FittedBox(
                                          child: Text(
                                              GCranking[rankingItem]![2]
                                                  .toString(),
                                              style: theme.textTheme.bodyLarge),
                                        )
                                      ],
                                    ),
                                  ),
                                  Spacer()
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
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
    final width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.gcname,
                style: theme.textTheme.headline3,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.Ranking.length,
                itemBuilder: (context, index) {
                  final hostelName = widget.Ranking[index];
                  final hostelPoints = widget.Ranking[index];
                  int itemnumber = index + 1;

                  return ListTile(
                    title: Row(
                      children: [
                        SizedBox(
                            width: width * 1 / 8,
                            child: Center(
                                child: Text('$itemnumber. ',
                                    style: theme.textTheme.bodyText1))),
                        Image.asset(
                          'assets/buynsell/DevcomLogo.png',
                          fit: BoxFit.fill,
                          height: 50,
                          width: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: FittedBox(
                            child: SizedBox(
                              child: Text(hostelName,
                                  style: theme.textTheme.bodyLarge),
                              width: width * 2 / 8,
                            ),
                          ),
                        ),
                        Spacer(),
                        FittedBox(
                          child: SizedBox(
                            child: Center(
                              child: Text((11 - itemnumber).toString(),
                                  style: theme.textTheme.titleMedium),
                            ),
                            width: width * 1 / 8,
                          ),
                        ),
                        Spacer(),
                        FittedBox(
                          child: Center(
                            child: SizedBox(
                              width: width / 6,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => numpad(
                                        hostelname: hostelName,
                                        gcname: widget.gcname,
                                        gcpreviouspoints: (11 - itemnumber),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Edit",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class numpad extends StatefulWidget {
  final String hostelname;
  final String gcname;
  final int gcpreviouspoints;

  numpad(
      {required this.gcname,
      required this.hostelname,
      required this.gcpreviouspoints});
  @override
  State<numpad> createState() => _numpadState();
}

class _numpadState extends State<numpad> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
              child: Center(
                  child: Text(
            widget.gcname + " > " + widget.hostelname,
            style: theme.textTheme.headline4,
          ))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
              child: Center(
                  child: Text(
            "Current Points : " + widget.gcpreviouspoints.toString(),
            style: theme.textTheme.headline5,
          ))),
        ),
        SizedBox(
          height: 50,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Add/Reduce Points'),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(
          height: 50,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Submit"),
        )
      ])),
    );
  }
}

class AddGC extends StatefulWidget {
  @override
  _AddGCState createState() => _AddGCState();
}

class _AddGCState extends State<AddGC> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TextEditingController _gcNameController = TextEditingController();
  GCType _selectedGcType = initial[2];
  List<String> _selectedHostels = [];

  // List of available GC types for the dropdown menu
  List<String> _gcTypes = ['Overall', 'Culturals GC', 'Sports GC', 'Tech GC'];

  // List of available hostels for selection

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Add GC",
                    style: theme.textTheme.headline3,
                  ),
                ),
                TextField(
                  controller: _gcNameController,
                  decoration: InputDecoration(
                    labelText: "GC Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<GCType>(
                  value: _selectedGcType,
                  onChanged: (value) {
                    setState(() {
                      _selectedGcType = value!;
                    });
                  },
                  items: initial.map((gcType) {
                    return DropdownMenuItem<GCType>(
                      value: gcType,
                      child: Text(gcType.toString()),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: "GC Type",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Select Participating Hostels:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Wrap(
                  spacing: 8.0,
                  children: hostels.map((hostel) {
                    return ChoiceChip(
                      label: Text(hostel),
                      selected: _selectedHostels.contains(hostel),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedHostels.add(hostel);
                          } else {
                            _selectedHostels.remove(hostel);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    String gcName = _gcNameController.text;
                    GCType gcType = _selectedGcType;
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("GC Added Successfully"),
                      ),
                    );
                  },
                  child: Text("Add GC"),
                ),
              ],
            ),
          ),
        ),
      ),
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
    );
  }
}
