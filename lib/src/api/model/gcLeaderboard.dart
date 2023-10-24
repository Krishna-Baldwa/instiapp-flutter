import 'package:json_annotation/json_annotation.dart';
import './mess.dart';
import 'package:InstiApp/src/api/model/body.dart';
part 'gcLeaderboard.g.dart';

@JsonSerializable()
class GC {
  @JsonKey(name: "TYPE_CHOICE")
  String? typeChoice;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "type")
  int? type;
  @JsonKey(name: "participating_hostels")
  List<String>? participating_hostels;
  @JsonKey(name: "body")
  String? roleBodies;

  GC({
    this.name,
    this.id,
    this.type,
    this.typeChoice,
    this.participating_hostels,
    this.roleBodies,
  });

  factory GC.fromJson(Map<String, dynamic> json) => _$GCFromJson(json);

  Map<String, dynamic> toJson() => _$GCToJson(this);
}

@JsonSerializable()
class GCHostelPoints {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "gc")
  String? gc;
  @JsonKey(name: "hostel")
  Hostel? hostel;
  @JsonKey(name: "points")
  int? points;

  GCHostelPoints({
    this.id,
    this.gc,
    this.hostel,
    this.points,
  });

  factory GCHostelPoints.fromJson(Map<String, dynamic> json) =>
      _$GCHostelPointsFromJson(json);

  Map<String, dynamic> toJson() => _$GCHostelPointsToJson(this);
}
