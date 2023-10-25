import 'package:InstiApp/src/api/model/gcLeaderboard.dart';
import 'package:InstiApp/src/api/model/mess.dart';
import 'package:InstiApp/src/api/request/gc_create_request.dart';
import 'package:InstiApp/src/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:InstiApp/src/drawer.dart';
import 'package:InstiApp/src/utils/common_widgets.dart';
import 'package:InstiApp/src/blocs/gcLeaderboard_bloc.dart';
import 'package:InstiApp/src/api/response/typeGC.dart';
import 'package:InstiApp/src/api/model/body.dart';

final List<GCType> initial = [
  GCType.Overall,
  GCType.Culturals,
  GCType.Sports,
  GCType.Tech,
];
final List<GCType> options = [
  GCType.Culturals,
  GCType.Sports,
  GCType.Tech,
];
GC gc = GC();

List<Hostel> hostels = [];
List<Body> bodies = [];

final Map<String, List<String>> differentGCs = {
  'Culturals GC': ['Dance GC', 'Music GC', 'Dramatics GC'],
  'Sports GC': ['Football GC', 'Chess GC', 'Basketball GC'],
  'Tech GC': ['Bot GC', 'Drone GC', 'Race GC'],
};

//GC Cards for type of GCs

class gcl_cards extends StatefulWidget {
  @override
  State<gcl_cards> createState() => _gcl_cardsState();
}

class _gcl_cardsState extends State<gcl_cards> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<_GCRankingsState> _gcRankingsKey = GlobalKey();
  bool firstBuild = true;
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var GCBloc = BlocProvider.of(context)!.bloc.gcbloc;

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
      floatingActionButton: (GCBloc.bloc.checkAllPermissions("GCAdm"))
          ? FloatingActionButton.extended(
              icon: Icon(Icons.add_outlined),
              label: Text(" Add GC "),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddGC()));
              },
            )
          : null,
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
      firstBuild = false;
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
                                      gc: rankingItem.gc!,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                              rankingItem.gc?.name ?? "",
                                              style:
                                                  theme.textTheme.headline6)),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/buynsell/DevcomLogo.png',
                                              fit: BoxFit.fill,
                                              height: 60,
                                              width: 60,
                                            ),
                                            Text(
                                                (rankingItem.hostels!.length ==
                                                        0)
                                                    ? ""
                                                    : rankingItem
                                                            .hostels?[0].name ??
                                                        "",
                                                style:
                                                    theme.textTheme.bodyLarge)
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/buynsell/DevcomLogo.png',
                                              fit: BoxFit.fill,
                                              height: 60,
                                              width: 60,
                                            ),
                                            Text(
                                                (rankingItem.hostels!.length <=
                                                        1)
                                                    ? ""
                                                    : rankingItem
                                                            .hostels?[1].name ??
                                                        "",
                                                style:
                                                    theme.textTheme.bodyLarge)
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/buynsell/DevcomLogo.png',
                                              fit: BoxFit.fill,
                                              height: 60,
                                              width: 60,
                                            ),
                                            Text(
                                                (rankingItem.hostels!.length <=
                                                        2)
                                                    ? ""
                                                    : rankingItem
                                                            .hostels?[2].name ??
                                                        "",
                                                style:
                                                    theme.textTheme.bodyLarge)
                                          ],
                                        ),
                                      ),
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
  final GC gc;

  @override
  particular_gc({required this.gc});
  State<particular_gc> createState() => _particular_gcState();
}

class _particular_gcState extends State<particular_gc> {
  bool firstBuild = true;
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    var GCBloc = BlocProvider.of(context)!.bloc.gcbloc;
    if (firstBuild) {
      GCBloc.getIndivGC(widget.gc.id!).then(
        (value) {
          setState(
            () {
              loading = false;
            },
          );
        },
      );
      firstBuild = false;
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
                widget.gc.name!,
                style: theme.textTheme.headline3,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await GCBloc.getIndivGC(widget.gc.id!);
                },
                child: StreamBuilder<List<TypeGCindie>>(
                    stream: GCBloc.indivgc,
                    builder:
                        (context, AsyncSnapshot<List<TypeGCindie>> snapshot) {
                      if (!snapshot.hasData)
                        return CircularProgressIndicatorExtended();
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final TypeGCindie rankingItem = snapshot.data![index];

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
                                          rankingItem.hostels!.name ?? "",
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
                                GCBloc.bloc.hasPermission(
                                        widget.gc.roleBodies!.bodyID ?? "",
                                        "GCAdm")
                                    ? FittedBox(
                                        child: Center(
                                          child: SizedBox(
                                            width: width / 6,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        numpad(
                                                      id: rankingItem.id ?? "",
                                                      hostelname: rankingItem
                                                              .hostels!.name ??
                                                          "",
                                                      gcname:
                                                          widget.gc.name ?? "",
                                                      gcpreviouspoints:
                                                          rankingItem.points ??
                                                              0,
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
                                      )
                                    : Container(),
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
  final String id;

  numpad(
      {required this.gcname,
      required this.hostelname,
      required this.gcpreviouspoints,
      required this.id});
  @override
  State<numpad> createState() => _numpadState();
}

class _numpadState extends State<numpad> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var GCBloc = BlocProvider.of(context)!.bloc.gcbloc;
    int points = 0;
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
              keyboardType: TextInputType.number,
              onChanged: (value) {
                points = int.parse(value);
              },
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                GCBloc.updatePoints(
                    GCHostelPoints()..points = points, widget.id);

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
  GCType? _selectedGcType;
  List<String> _selectedHostels = [];
  bool firstBuild = true;

  @override
  Widget build(BuildContext context) {
    var GCBloc = BlocProvider.of(context)!.bloc.gcbloc;
    var theme = Theme.of(context);

    if (firstBuild) {
      GCBloc.getHostelBodies().then((value) {
        setState(() {
          hostels = value.hostels ?? [];
          bodies = value.bodies ?? [];
          print(bodies);
        });
      });
      gc.participating_hostels = [];
      firstBuild = false;
    }

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
                  onChanged: (value) {
                    gc.name = value;
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<GCType>(
                  value: _selectedGcType,
                  onChanged: (value) {
                    setState(
                      () {
                        _selectedGcType = value!;
                        if (value == GCType.Culturals) {
                          gc.type = 3;
                        }
                        if (value == GCType.Sports) {
                          gc.type = 2;
                        }
                        if (value == GCType.Tech) {
                          gc.type = 1;
                        }
                      },
                    );
                  },
                  items: options.map(
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
                StreamBuilder<List<HostelBodies>>(
                    stream: GCBloc.hostelBodies,
                    builder:
                        (context, AsyncSnapshot<List<HostelBodies>> snapshot) {
                      return DropdownButtonFormField<Body>(
                        onChanged: (value) {
                          setState(
                            () {
                              gc.roleBodies = value;
                            },
                          );
                        },
                        items: bodies.map(
                          (body) {
                            return DropdownMenuItem<Body>(
                              value: body,
                              child: Text(body.toString()),
                            );
                          },
                        ).toList(),
                        decoration: InputDecoration(
                          labelText: "GC Organising Body",
                          border: OutlineInputBorder(),
                        ),
                      );
                    }),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Select Participating Hostels:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                StreamBuilder<List<HostelBodies>>(
                    stream: GCBloc.hostelBodies,
                    builder:
                        (context, AsyncSnapshot<List<HostelBodies>> snapshot) {
                      return Wrap(
                        spacing: 8.0,
                        children: hostels.map(
                          (hostel) {
                            print(gc.participating_hostels!.contains(hostel));
                            return ChoiceChip(
                              backgroundColor: theme.colorScheme.surfaceVariant,
                              selectedColor: Colors.amber,
                              label: Text(hostel.name ?? ""),
                              selected: (gc.participating_hostels ?? [])
                                  .contains(hostel),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    gc.participating_hostels?.add(hostel);
                                  } else {
                                    gc.participating_hostels?.remove(hostel);
                                  }
                                });
                              },
                            );
                          },
                        ).toList(),
                      );
                    }),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async {
                    print(gc.roleBodies?.bodyID);
                    GCCreateRequest req = GCCreateRequest()
                      ..name = gc.name
                      ..participating_hostels =
                          gc.participating_hostels!.map((e) => e.id!).toList()
                      ..roleBodies = gc.roleBodies!.bodyID
                      ..type = gc.type;
                    try {
                      await GCBloc.addGC(req);
                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("GC Added Successfully"),
                        ),
                      );
                    } catch (e) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Something went wrong"),
                        ),
                      );
                    }
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
