import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:keep_it_fresh/lib.dart';
import 'package:keep_it_fresh/lib.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
  late Timer _timer;

  bool showChart = false;

  final HumidityCubit _humidityCubit = HumidityCubit();
  final TemparatureCubit _temparatureCubit = TemparatureCubit();

  final ValueNotifier<double> _temparatureNotifier = ValueNotifier(0);
  final ValueNotifier<double> _humidityNotifier = ValueNotifier(0);

  final ValueNotifier<List<Humidity>> _listHumidity = ValueNotifier([]);
  final ValueNotifier<List<Temparature>> _listTemparature = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    startFetchingData();
  }

  void startFetchingData() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _humidityCubit.getListHumidity(1);
      _temparatureCubit.getListTemparature(1);
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Hủy timer khi widget bị dispose để tránh memory leaks
    _timer.cancel(); // Cancel the timer when the widget is disposed
  }

  String formatedDate(String dateTime) {
    DateTime date = DateTime.parse(dateTime);

    String formattedDateTime = DateFormat('HH:mm').format(date);

    return formattedDateTime;
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
      body: MultiBlocProvider(
        providers: [
          BlocProvider<HumidityCubit>.value(
            value: _humidityCubit,
          ),
          BlocProvider<TemparatureCubit>.value(
            value: _temparatureCubit,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<HumidityCubit, HumidityState>(
              listener: (context, state) {
                state.maybeWhen(
                    orElse: () {},
                    success: (data) {
                      _humidityNotifier.value =
                          customRound(data.last.value ?? 20);
                      _listHumidity.value = data;
                    });
              },
            ),
            BlocListener<TemparatureCubit, TemparatureState>(
              listener: (context, state) {
                state.maybeWhen(
                    orElse: () {},
                    success: (data) {
                      _temparatureNotifier.value =
                          customRound(data.last.value ?? 20);
                      _listTemparature.value = data;
                    });
              },
            ),
          ],
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CommonText(
                  'Show chart',
                  variant: Variant.h5,
                ),
                Switch(
                    value: showChart,
                    onChanged: (value) => setState(() {
                          showChart = value;
                        })),
                if (showChart) ...chartView() else simpleDataView()
              ],
            ),
          ),
        ),
      ),
    );
  }

  double customRound(double number) {
    double value = double.parse((number * 10).toStringAsFixed(1));
    return value.roundToDouble() / 10;
  }

  Widget simpleDataView() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
                valueListenable: _temparatureNotifier,
                builder: (ctx, data, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        Assets.icons.icTemparature,
                        height: 50,
                        width: 50,
                      ),
                      const CommonText('Current Temparature:'),
                      _temparatureNotifier.value <
                              (widget.order.defaultTemperature ?? 22)
                          ? const SizedBox.shrink()
                          : const CommonText(
                              'Your order\'s temparature is too high',
                              textColor: Colors.red,
                            ),
                      CommonText(
                        '${_temparatureNotifier.value.toString()} / ${widget.order.defaultTemperature}',
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: 20,
            ),
            ValueListenableBuilder(
                valueListenable: _humidityNotifier,
                builder: (ctx, data, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        Assets.icons.icHumidity,
                        height: 50,
                        width: 50,
                      ),
                      const CommonText('Current Humidity:'),
                      _humidityNotifier.value <
                              (widget.order.defaultHumidity ?? 22)
                          ? const SizedBox.shrink()
                          : const CommonText(
                              'Your order\'s temparature is too high',
                              textColor: Colors.red,
                            ),
                      CommonText(
                          '${_humidityNotifier.value.toString()} / ${widget.order.defaultHumidity}'),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }

  List<Widget> chartView() {
    return [
      Expanded(
        child: Row(
          children: [
            ValueListenableBuilder(
                valueListenable: _humidityNotifier,
                builder: (ctx, data, child) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 196,
                        child: SfCartesianChart(
                            // Initialize category axis
                            title: ChartTitle(text: 'Humidity'),
                            primaryXAxis: CategoryAxis(),
                            series: <CartesianSeries>[
                              LineSeries<Humidity, String>(
                                dataSource: _listHumidity.value,
                                xValueMapper: (Humidity data, _) =>
                                    formatedDate(data.timestamp ?? ''),
                                yValueMapper: (Humidity data, _) => data.value,
                              )
                            ]),
                      ),
                      _humidityNotifier.value <
                              (widget.order.defaultHumidity ?? 22)
                          ? const SizedBox.shrink()
                          : const CommonText(
                              'Your order\'s temparature is too high',
                              textColor: Colors.red,
                            ),
                    ],
                  );
                }),
            ValueListenableBuilder(
                valueListenable: _temparatureNotifier,
                builder: (ctx, data, child) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 196,
                        child: SfCartesianChart(
                            title: ChartTitle(text: 'Temparature'),
                            // Initialize category axis
                            primaryXAxis: CategoryAxis(),
                            series: <CartesianSeries>[
                              LineSeries<Temparature, String>(
                                dataSource: _listTemparature.value,
                                xValueMapper: (Temparature data, _) =>
                                    formatedDate(data.timestamp ?? ''),
                                yValueMapper: (Temparature data, _) =>
                                    data.value,
                              )
                            ]),
                      ),
                      _temparatureNotifier.value <
                              (widget.order.defaultTemperature ?? 22)
                          ? const SizedBox.shrink()
                          : const CommonText(
                              'Your order\'s \n temparature is too high',
                              textColor: Colors.red,
                              maxLines: 5,
                              textAlign: TextAlign.center,
                            ),
                    ],
                  );
                }),
          ],
        ),
      )
    ];
  }
}



// Chart
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

// Chart Humidity
// SfRadialGauge(
//                   axes: <RadialAxis>[
//                     RadialAxis(
//                       minimum: 0,
//                       maximum: widget.order.defaultHumidity ?? 0,
//                       ranges: <GaugeRange>[
//                         GaugeRange(
//                           startValue: 0,
//                           endValue: data.last.value ?? 0,
//                           color: Colors.blue,
//                         ),
//                         GaugeRange(
//                           startValue: data.last.value ?? 0,
//                           endValue: widget.order.defaultHumidity ?? 0,
//                           color: Colors.grey,
//                         ),
//                       ],
//                       pointers: <GaugePointer>[
//                         MarkerPointer(
//                           value: data.last.value ?? 0,
//                           markerType: MarkerType.circle,
//                           color: Colors.blue,
//                         ),
//                       ],
//                     ),
//                   ],
//                 )
