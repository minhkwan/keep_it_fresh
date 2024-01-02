import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keep_it_fresh/lib.dart';
import 'package:keep_it_fresh/pages/order/order_detail_page.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({super.key, required this.order});

  String formatedDate(String dateTime) {
    DateTime date = DateTime.parse(dateTime);

    String formattedDateTime = DateFormat('HH:mm dd-MM-yyyy').format(date);

    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => OrderDetailPage(
                order: order,
              ),
            ),
          );
        },
        child: Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: AppColors.green,
              width: 3,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          margin: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      Assets.images.imgFreshTruck.path,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      'Order #${order.id}',
                      fontStyle: FontStyle.bold,
                    ),
                    CommonText(
                      order.name ?? '',
                      fontStyle: FontStyle.semibold,
                    ),
                    CommonText(
                        'Start date: ${formatedDate(order.startDate ?? '')}'),
                    CommonText(
                        'End date: ${formatedDate(order.endDate ?? '')}'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
