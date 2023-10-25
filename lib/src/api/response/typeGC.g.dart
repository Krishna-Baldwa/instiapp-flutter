// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typeGC.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeGC _$TypeGCFromJson(Map<String, dynamic> json) => TypeGC(
      gc: json['gc'] == null
          ? null
          : GC.fromJson(json['gc'] as Map<String, dynamic>),
      hostels: (json['hostels'] as List<dynamic>?)
          ?.map((e) => Hostel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TypeGCToJson(TypeGC instance) => <String, dynamic>{
      'gc': instance.gc,
      'hostels': instance.hostels,
    };

TypeGCindie _$TypeGCindieFromJson(Map<String, dynamic> json) => TypeGCindie(
      hostels: json['hostel'] == null
          ? null
          : Hostel.fromJson(json['hostel'] as Map<String, dynamic>),
      points: json['points'] as int?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$TypeGCindieToJson(TypeGCindie instance) =>
    <String, dynamic>{
      'hostel': instance.hostels,
      'points': instance.points,
      'id': instance.id,
    };

HostelBodies _$HostelBodiesFromJson(Map<String, dynamic> json) => HostelBodies(
      hostels: (json['hostels'] as List<dynamic>?)
          ?.map((e) => Hostel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bodies: (json['bodies'] as List<dynamic>?)
          ?.map((e) => Body.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HostelBodiesToJson(HostelBodies instance) =>
    <String, dynamic>{
      'hostels': instance.hostels,
      'bodies': instance.bodies,
    };
