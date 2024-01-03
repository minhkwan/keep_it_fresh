import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keep_it_fresh/lib.dart';

part 'temparature_cubit.freezed.dart';

part 'temparature_state.dart';

class TemparatureCubit extends Cubit<TemparatureState> {
  Dio orderService = Dio();

  TemparatureCubit() : super(const TemparatureState.initial());

  void getListTemparature(int page) async {
    emit(const TemparatureState.loading());
    try {
      List<Temparature> data = [];
      final response =
          await orderService.get('http://192.168.1.7:8000/tensor-temperature');

      for (dynamic order in response.data) {
        data.add(Temparature.fromJson(order));
      }
      emit(
        TemparatureState.success(
          data,
        ),
      );
    } catch (e) {}
  }
}
