// import 'package:InstiApp/src/api/model/UserTag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gc_create_request.g.dart';

@JsonSerializable()
class GCCreateRequest {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "type")
  int? type;
  @JsonKey(name: "participating_hostels_id")
  List<String>? participating_hostels;
  @JsonKey(name: "body_id")
  String? roleBodies;

  GCCreateRequest({
    this.name,
    this.id,
    this.type,
    this.participating_hostels,
    this.roleBodies,
  });
  factory GCCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$GCCreateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GCCreateRequestToJson(this);
}
