part of 'humidity_cubit.dart';

@freezed
class HumidityState with _$HumidityState {
  const factory HumidityState.initial() = _Initial;

  const factory HumidityState.loading() = _Loading;

  const factory HumidityState.success(List<Humidity> data) = _Success;

  const factory HumidityState.error(dynamic error) = _Error;
}
