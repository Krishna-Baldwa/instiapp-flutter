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
