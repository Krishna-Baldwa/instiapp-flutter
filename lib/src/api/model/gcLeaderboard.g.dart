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
    );

Map<String, dynamic> _$GCToJson(GC instance) => <String, dynamic>{
      'TYPE_CHOICE': instance.typeChoice,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'participating_hostels': instance.participating_hostels,
    };

GCHostelPoints _$GCHostelPointsFromJson(Map<String, dynamic> json) =>
    GCHostelPoints(
      id: json['id'] as String?,
      gc: json['gc'] as String?,
      hostel: json['hostels'] == null
          ? null
          : Hostel.fromJson(json['hostels'] as Map<String, dynamic>),
      points: json['points'] as int?,
    );

Map<String, dynamic> _$GCHostelPointsToJson(GCHostelPoints instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gc': instance.gc,
      'hostels': instance.hostel,
      'points': instance.points,
    };
