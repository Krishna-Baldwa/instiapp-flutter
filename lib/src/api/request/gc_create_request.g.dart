// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gc_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GCCreateRequest _$GCCreateRequestFromJson(Map<String, dynamic> json) =>
    GCCreateRequest(
      name: json['name'] as String?,
      id: json['id'] as String?,
      type: json['type'] as int?,
      participating_hostels:
          (json['participating_hostels_id'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      roleBodies: json['body_id'] as String?,
    );

Map<String, dynamic> _$GCCreateRequestToJson(GCCreateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'participating_hostels_id': instance.participating_hostels,
      'body_id': instance.roleBodies,
    };
