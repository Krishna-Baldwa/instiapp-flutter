// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gcLeaderboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GC _$GCFromJson(Map<String, dynamic> json) => GC(
      name: json['name'] as String?,
      id: json['id'] as String?,
      type: json['type'] as int?,
      typeChoice: json['TYPE_CHOICE'] as String?,
      participating_hostels: (json['participating_hostels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      roleBodies: (json['body'] as List<dynamic>?)
          ?.map((e) => Body.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GCToJson(GC instance) => <String, dynamic>{
      'TYPE_CHOICE': instance.typeChoice,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'participating_hostels': instance.participating_hostels,
      'body': instance.roleBodies,
    };

GCHostelPoints _$GCHostelPointsFromJson(Map<String, dynamic> json) =>
    GCHostelPoints(
      id: json['id'] as String?,
      gc: json['gc'] as String?,
      hostel: json['hostel'] == null
          ? null
          : Hostel.fromJson(json['hostel'] as Map<String, dynamic>),
      points: json['points'] as int?,
    );

Map<String, dynamic> _$GCHostelPointsToJson(GCHostelPoints instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gc': instance.gc,
      'hostel': instance.hostel,
      'points': instance.points,
    };
