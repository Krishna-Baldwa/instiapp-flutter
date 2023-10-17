import 'package:InstiApp/src/api/model/gcLeaderboard.dart';
import 'package:InstiApp/src/blocs/ia_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum GCType {
  Overall,
  Tech,
  Cult,
  Sports
}

class GCbloc {
  final String storageID = "BuynSellPost";

  InstiAppBloc bloc;

  List<GCHostelPoints> _gcPosts = [];

  ValueStream<List<GCHostelPoints>> get gcPosts => _gcSubject.stream;
  final _gcSubject = BehaviorSubject<List<GCHostelPoints>>();

  String query = "";

  GCbloc(this.bloc);

  get buynsellpost => null;

  Future<void> refresh(GCType Type) async {
    switch(Type){
      case GCType.Overall:
        _gcPosts =
      (await bloc.client.getGCLB(bloc.getSessionIdHeader()));
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
}
