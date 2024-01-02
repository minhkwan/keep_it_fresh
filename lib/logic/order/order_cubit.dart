import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keep_it_fresh/model/order.dart';

part 'order_cubit.freezed.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  Dio orderService = Dio();

  OrderCubit() : super(const OrderState.initial());

  void getListOrders(int page) async {
    emit(const OrderState.loading());
    try {
      List<Order> data = [];
      final response =
          await orderService.get('http://192.168.1.7:8000/transport');

      for (dynamic order in response.data) {
        data.add(Order.fromJson(order));
      }
      emit(
        OrderState.success(
          data,
        ),
      );
    } catch (e) {}
  }
}
