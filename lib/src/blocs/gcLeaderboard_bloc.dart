import 'package:InstiApp/src/api/model/gcLeaderboard.dart';
import 'package:InstiApp/src/blocs/ia_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum GCType { Overall, Tech, Cult, Sports }

class GCbloc {
  final String storageID = "GCPost";

  InstiAppBloc bloc;
//add dadta type here
  List<GCHostelPoints> _gcPosts = [];
  List<GC> _gcList = [];
  List<GCHostelPoints> _indivGC = [];
//Build your stream here
  ValueStream<List<GCHostelPoints>> get gcPosts => _gcSubject.stream;
  final _gcSubject = BehaviorSubject<List<GCHostelPoints>>();

  ValueStream<List<GC>> get gcLists => _gclSubject.stream;
  final _gclSubject = BehaviorSubject<List<GC>>();

  ValueStream<List<GCHostelPoints>> get indivgc => _indivgcSubject.stream;
  final _indivgcSubject = BehaviorSubject<List<GCHostelPoints>>();

  String query = "";

  GCbloc(this.bloc);

  get gcposts => null;

  Future<void> getIndivGC(String gcId) async {
    _indivGC = await bloc.client.indivGC(bloc.getSessionIdHeader(), gcId);
    _indivgcSubject.add(_indivGC);
  }

  Future<void> refresh(GCType Type) async {
    switch (Type) {
      case GCType.Overall:
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
      case GCType.Cult:
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
        _gcList = (await bloc.client.getListGC(bloc.getSessionIdHeader(), 1));
        break;
      case GCType.Sports:
        _gcList = (await bloc.client.getListGC(bloc.getSessionIdHeader(), 2));
        break;
      case GCType.Cult:
        _gcList = (await bloc.client.getListGC(bloc.getSessionIdHeader(), 3));
        break;
      default:
        return;
    }

    _gclSubject.add(_gcList);
  }

  Future<void> addGC(GC gc) async {
    await bloc.client.addGC(bloc.getSessionIdHeader(), gc);
  }
}
