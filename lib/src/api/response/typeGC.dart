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
