// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllThings _$AllThingsFromJson(Map<String, dynamic> json) => AllThings(
      things: (json['things'] as List<dynamic>)
          .map((e) => Thing.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllThingsToJson(AllThings instance) => <String, dynamic>{
      'things': instance.things.map((e) => e.toJson()).toList(),
    };

Thing _$ThingFromJson(Map<String, dynamic> json) => Thing(
      done: json['done'] as bool,
      stuff: json['stuff'] as String,
    );

Map<String, dynamic> _$ThingToJson(Thing instance) => <String, dynamic>{
      'done': instance.done,
      'stuff': instance.stuff,
    };
