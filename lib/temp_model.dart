import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'temp_model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.

@JsonSerializable(explicitToJson: true)
class AllThings {
  AllThings({required this.things});

  final List<Thing> things;

  factory AllThings.fromJson(Map<String, dynamic> json) =>
      _$AllThingsFromJson(json);

  Map<String, dynamic> toJson() => _$AllThingsToJson(this);
}

@JsonSerializable()
class Thing {
  Thing({required this.done, required this.stuff});

  final bool done;
  final String stuff;

  factory Thing.fromJson(Map<String, dynamic> json) => _$ThingFromJson(json);

  Map<String, dynamic> toJson() => _$ThingToJson(this);
}
