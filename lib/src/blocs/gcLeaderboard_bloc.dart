import 'package:InstiApp/src/api/model/gcLeaderboard.dart';
import 'package:InstiApp/src/api/request/gc_create_request.dart';
import 'package:InstiApp/src/blocs/ia_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:InstiApp/src/api/response/typeGC.dart';

enum GCType { Overall, Tech, Culturals, Sports }

class GCbloc {
  final String storageID = "GCPost";

  InstiAppBloc bloc;
//add data type here
  List<GCHostelPoints> _gcPosts = [];
  List<TypeGC> _gcList = [];
  List<TypeGCindie> _indivGC = [];
  List<HostelBodies> _hostelAndBodies = [];
//Build your stream here
  ValueStream<List<GCHostelPoints>> get gcPosts => _gcSubject.stream;
  final _gcSubject = BehaviorSubject<List<GCHostelPoints>>();

  ValueStream<List<TypeGC>> get gcLists => _gclSubject.stream;
  final _gclSubject = BehaviorSubject<List<TypeGC>>();

  ValueStream<List<TypeGCindie>> get indivgc => _indivgcSubject.stream;
  final _indivgcSubject = BehaviorSubject<List<TypeGCindie>>();

  ValueStream<List<HostelBodies>> get hostelBodies =>
      _hostelBodiesSubject.stream;
  final _hostelBodiesSubject = BehaviorSubject<List<HostelBodies>>();

  String query = "";

  GCbloc(this.bloc);

  get gcposts => null;
  Future<HostelBodies> getHostelBodies() async {
    // _hostelAndBodies =
    //     await bloc.client.getHostelandBodies(bloc.getSessionIdHeader());
    // _hostelBodiesSubject.add(_hostelAndBodies);
    return await bloc.client.getHostelandBodies(bloc.getSessionIdHeader());
  }

  Future<void> getIndivGC(String gcId) async {
    print("Indiviual GC called");
    _indivGC = await bloc.client.indivGC(bloc.getSessionIdHeader(), gcId);
    _indivgcSubject.add(_indivGC);
  }

  Future<void> refresh(GCType Type) async {
    switch (Type) {
      case GCType.Overall:
        print("Overall");
        _gcPosts = (await bloc.client.getGCLB(bloc.getSessionIdHeader()));

        break;
      case GCType.Tech:
        _gcPosts =
            (await bloc.client.getTypeGCLB(bloc.getSessionIdHeader(), 1));

        break;
      case GCType.Sports:
        _gcPosts =
            (await bloc.client.getTypeGCLB(bloc.getSessionIdHeader(), 2));

        break;
      case GCType.Culturals:
        _gcPosts =
            (await bloc.client.getTypeGCLB(bloc.getSessionIdHeader(), 3));

        break;
      default:
        return;
    }

    _gcSubject.add(_gcPosts);
  }

  Future<void> gcList(GCType Type) async {
    switch (Type) {
      case GCType.Tech:
        print("Techaa");
        _gcList = (await bloc.client.getListGC(bloc.getSessionIdHeader(), 1));
        break;
      case GCType.Sports:
        print("Sportsaa");
        _gcList = (await bloc.client.getListGC(bloc.getSessionIdHeader(), 2));
        break;
      case GCType.Culturals:
        print("Cultaa");
        _gcList = (await bloc.client.getListGC(bloc.getSessionIdHeader(), 3));
        break;
      default:
        return;
    }

    _gclSubject.add(_gcList);
  }

  Future<void> addGC(GCCreateRequest gc) async {
    await bloc.client.addGC(bloc.getSessionIdHeader(), gc);
  }

  Future<void> updatePoints(GCHostelPoints points, String id) async {
    await bloc.client.updateHostelPoints(bloc.getSessionIdHeader(), id, points);
  }
}
