part of 'temparature_cubit.dart';

@freezed
class TemparatureState with _$TemparatureState {
  const factory TemparatureState.initial() = _Initial;

  const factory TemparatureState.loading() = _Loading;

  const factory TemparatureState.success(List<Temparature> data) = _Success;

  const factory TemparatureState.error(dynamic error) = _Error;
}
