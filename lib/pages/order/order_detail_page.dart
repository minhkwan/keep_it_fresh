import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_it_fresh/lib.dart';
import 'package:keep_it_fresh/logic/humidity/humidity_cubit.dart';
import 'package:keep_it_fresh/model/humidity.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrderDetailPage extends StatefulWidget {
  final Order order;
  const OrderDetailPage({
    super.key,
    required this.order,
  });

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: CommonText(
          'Order #${widget.order.id}',
          textColor: Colors.white,
          variant: Variant.h5,
        ),
        centerTitle: true,
      ),
      body: BlocProvider<HumidityCubit>(
        create: (context) => HumidityCubit()..getListOrders(1),
        child: BlocBuilder<HumidityCubit, HumidityState>(builder: (ctx, state) {
          return state.maybeWhen(
            orElse: () {
              return const SizedBox.shrink();
            },
            success: (data) {
              return SizedBox(
                height: 200,
                width: 200,
                child: CommonText(
                    'Current Value: ${customRound(data.last.value ?? 0)}'),
              );
            },
          );
        }),
      ),
    );
  }

  double customRound(double number) {
    double value = double.parse((number * 10).toStringAsFixed(1));
    return value.roundToDouble() / 10;
  }
}

//Chart
// SizedBox(
//                 height: 200,
//                 width: 200,
//                 child: SfCartesianChart(
//                     // Initialize category axis
//                     primaryXAxis: CategoryAxis(),
//                     series: <CartesianSeries>[
//                       LineSeries<Humidity, String>(
//                           dataSource: data,
//                           xValueMapper: (Humidity data, _) => data.timestamp,
//                           yValueMapper: (Humidity data, _) => data.value,
//                           dataLabelSettings:
//                               const DataLabelSettings(isVisible: true))
//                     ]),
//               );
