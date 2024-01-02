part of 'order_cubit.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.initial() = _Initial;

  const factory OrderState.loading() = _Loading;

  const factory OrderState.success(List<Order> data) = _Success;

  const factory OrderState.error(dynamic error) = _Error;
}
