import 'package:json_annotation/json_annotation.dart';

part 'base_data_list.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseDataListDto<T> {
  List<T> data;

  BaseDataListDto({
    required this.data,
  });

  factory BaseDataListDto.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseDataListDtoFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(T Function(Object? json) toJsonT) =>
      _$BaseDataListDtoToJson(this, toJsonT);
}
