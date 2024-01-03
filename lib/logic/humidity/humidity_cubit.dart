import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keep_it_fresh/model/humidity.dart';
import 'package:keep_it_fresh/model/order.dart';

part 'humidity_cubit.freezed.dart';

part 'humidity_state.dart';

class HumidityCubit extends Cubit<HumidityState> {
  Dio orderService = Dio();

  HumidityCubit() : super(const HumidityState.initial());

  void getListHumidity(int page) async {
    emit(const HumidityState.loading());
    try {
      List<Humidity> data = [];
      final response =
          await orderService.get('http://192.168.1.7:8000/tensor-humidity');

      for (dynamic order in response.data) {
        data.add(Humidity.fromJson(order));
      }
      emit(
        HumidityState.success(
          data,
        ),
      );
    } catch (e) {}
  }
}
