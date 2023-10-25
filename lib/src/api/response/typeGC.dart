import 'package:json_annotation/json_annotation.dart';
import '../model/mess.dart';
import 'package:InstiApp/src/api/model/body.dart';
import '../model/gcLeaderboard.dart';
part 'typeGC.g.dart';

@JsonSerializable()
class TypeGC {
  @JsonKey(name: "gc")
  GC? gc;
  @JsonKey(name: "hostels")
  List<Hostel>? hostels;

  TypeGC({
    this.gc,
    this.hostels,
  });

  factory TypeGC.fromJson(Map<String, dynamic> json) => _$TypeGCFromJson(json);

  Map<String, dynamic> toJson() => _$TypeGCToJson(this);
}

@JsonSerializable()
class TypeGCindie {
  @JsonKey(name: "hostel")
  Hostel? hostels;
  @JsonKey(name: "points")
  int? points;
  @JsonKey(name: "id")
  String? id;

  TypeGCindie({
    this.hostels,
    this.points,
    this.id,
  });
  factory TypeGCindie.fromJson(Map<String, dynamic> json) =>
      _$TypeGCindieFromJson(json);

  Map<String, dynamic> toJson() => _$TypeGCindieToJson(this);
}

@JsonSerializable()
class HostelBodies {
  @JsonKey(name: "hostels")
  List<Hostel>? hostels;
  @JsonKey(name: "bodies")
  List<Body>? bodies;

  HostelBodies({
    this.hostels,
    this.bodies,
  });
  factory HostelBodies.fromJson(Map<String, dynamic> json) =>
      _$HostelBodiesFromJson(json);

  Map<String, dynamic> toJson() => _$HostelBodiesToJson(this);
}
