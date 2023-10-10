import 'package:InstiApp/src/api/model/gcLeaderboard.dart';
import 'package:InstiApp/src/blocs/ia_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum GCLType { All }

class GCleaderboardBloc {
  final String storageID = "GC";

  late InstiAppBloc bloc;

  List<GC> _GC = [];
  ValueStream<List<GC>> get gc => _gcSubject.stream;
  final _gcSubject = BehaviorSubject<List<GC>>();
  String query = "";
}