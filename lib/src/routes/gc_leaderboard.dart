import 'package:InstiApp/src/api/model/gcLeaderboard.dart';
import 'package:InstiApp/src/api/model/mess.dart';
import 'package:InstiApp/src/bloc_provider.dart';
import 'package:InstiApp/src/blocs/buynsell_post_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:InstiApp/src/drawer.dart';
import 'package:InstiApp/src/utils/common_widgets.dart';
import '../api/model/user.dart';
import 'package:InstiApp/src/blocs/gcLeaderboard_bloc.dart';
import 'package:InstiApp/src/api/response/typeGC.dart';

final List<GCType> initial = [
  GCType.Overall,
  GCType.Culturals,
  GCType.Sports,
  GCType.Tech,
];
GC gc = GC();
List<Hostel> hostels = [];

final Map<String, List<String>> differentGCs = {
  'Culturals GC': ['Dance GC', 'Music GC', 'Dramatics GC'],
  'Sports GC': ['Football GC', 'Chess GC', 'Basketball GC'],
  'Tech GC': ['Bot GC', 'Drone GC', 'Race GC'],
};

final List<String> GCranking = [
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
];

//GC Cards for type of GCs

class gcl_cards extends StatefulWidget {
  @override
  State<gcl_cards> createState() => _gcl_cardsState();
}

class _gcl_cardsState extends State<gcl_cards> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<_GCRankingsState> _gcRankingsKey = GlobalKey();

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
                            key: _gcRankingsKey,
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
    required Key key,
  }) : super(key: key);

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
      GCBloc.gcList(widget.gcName).then(
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
                                SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: FittedBox(
                                    child: SizedBox(
                                      child: Text(
                                          rankingItem.hostel?.name ?? "blank",
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
                  RefreshIndicator(
                    onRefresh: () async {
                      print("Reached here 2");
                      await GCBloc.refresh(widget.gcName);
                    },
                    child: StreamBuilder<List<GCHostelPoints>>(
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
                                      child: Text(
                                          rankingItem.hostel?.name ?? "",
                                          style: theme.textTheme.bodyLarge),
                                      width: width * 2 / 8,
                                    )),
                                  ),

                                  FittedBox(
                                      child: SizedBox(
                                    child: Center(
                                        child: Text(
                                            rankingItem.points.toString(),
                                            style:
                                                theme.textTheme.titleMedium)),
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
                  ),
                  StreamBuilder<List<TypeGC>>(
                    stream: GCBloc.gcLists,
                    builder: (context, AsyncSnapshot<List<TypeGC>> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicatorExtended();
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final rankingItem = snapshot.data![index];
                          print(rankingItem.hostels!.length);

                          return ListTile(
                            title: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => particular_gc(
                                      gcname: rankingItem.gc!.name ?? "",
                                      gcId: rankingItem.gc!.id ?? "",
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Spacer(),
                                      SizedBox(
                                          width: width / 3,
                                          child: Text(
                                              rankingItem.gc?.name ?? "",
                                              style:
                                                  theme.textTheme.headline6)),
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
                                                  (rankingItem.hostels!
                                                              .length ==
                                                          0)
                                                      ? ""
                                                      : rankingItem.hostels?[0]
                                                              .name ??
                                                          "",
                                                  style: theme
                                                      .textTheme.bodyLarge),
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
                                                  (rankingItem.hostels!
                                                              .length ==
                                                          1)
                                                      ? ""
                                                      : rankingItem.hostels?[1]
                                                              .name ??
                                                          "",
                                                  style: theme
                                                      .textTheme.bodyLarge),
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
                                                  (rankingItem.hostels?[2] ==
                                                          null)
                                                      ? ""
                                                      : rankingItem.hostels?[2]
                                                              .name ??
                                                          "",
                                                  style: theme
                                                      .textTheme.bodyLarge),
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
  final String gcId;

  // final GCHostelPoints Ranking;

  @override
  particular_gc({required this.gcname, required this.gcId});
  State<particular_gc> createState() => _particular_gcState();
}

class _particular_gcState extends State<particular_gc> {
  bool firstBuild = true;
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    var GCBloc = BlocProvider.of(context)!.bloc.gcbloc;
    if (firstBuild) {
      GCBloc.getIndivGC(widget.gcId).then(
        (value) {
          setState(
            () {
              loading = false;
            },
          );
        },
      );
    }

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
              child: RefreshIndicator(
                onRefresh: () async {
                  await GCBloc.getIndivGC(widget.gcId);
                },
                child: StreamBuilder<List<GCHostelPoints>>(
                    stream: GCBloc.indivgc,
                    builder: (context,
                        AsyncSnapshot<List<GCHostelPoints>> snapshot) {
                      if (!snapshot.hasData)
                        return CircularProgressIndicatorExtended();
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final GCHostelPoints rankingItem =
                              snapshot.data![index];

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
                                      child: Text(
                                          rankingItem.hostel!.name ?? "",
                                          style: theme.textTheme.bodyLarge),
                                      width: width * 2 / 8,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                FittedBox(
                                  child: SizedBox(
                                    child: Center(
                                      child: Text(rankingItem.points.toString(),
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
                                                hostelname:
                                                    rankingItem.hostel!.name ??
                                                        "",
                                                gcname: widget.gcname,
                                                gcpreviouspoints:
                                                    (11 - itemnumber),
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
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Change Points
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Center(
                  child: Text(
                    widget.gcname + " > " + widget.hostelname,
                    style: theme.textTheme.headline4,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Center(
                  child: Text(
                    "Current Points : " + widget.gcpreviouspoints.toString(),
                    style: theme.textTheme.headline5,
                  ),
                ),
              ),
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
          ],
        ),
      ),
    );
  }
}

//Add GC
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
  List<String> _gcTypes = ['Culturals', 'Sports', 'Tech GC'];
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
                TextFormField(
                  controller: _gcNameController,
                  decoration: InputDecoration(
                    labelText: "GC Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    gc.name = value;
                    print(gc.name);
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<GCType>(
                  value: _selectedGcType,
                  onChanged: (value) {
                    setState(
                      () {
                        _selectedGcType = value!;
                      },
                    );
                  },
                  items: initial.map(
                    (gcType) {
                      return DropdownMenuItem<GCType>(
                        value: gcType,
                        child: Text(gcType.toString().substring(7)),
                      );
                    },
                  ).toList(),
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
                  children: hostels.map(
                    (hostel) {
                      return ChoiceChip(
                        label: Text(hostel.name ?? ""),
                        selected: _selectedHostels.contains(hostels),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedHostels.add(hostel.id ?? "");
                            } else {
                              _selectedHostels.remove(hostel.id ?? "");
                            }
                          });
                        },
                      );
                    },
                  ).toList(),
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
