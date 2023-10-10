import 'package:json_annotation/json_annotation.dart';
import './mess.dart';
part 'gcLeaderboard.g.dart';

@JsonSerializable()
class GC{
  @JsonKey(name: "TYPE_CHOICE")
  String? typeChoice;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "type")
  int? type;
}
@JsonSerializable()
class GCHostelPoints{
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "gc")
  String? gc;
  @JsonKey(name: "hostels")
  Hostel? hostel;
  @JsonKey(name: "points")
  int? points;
  @JsonKey(name: "participants")
  String? participants;
}