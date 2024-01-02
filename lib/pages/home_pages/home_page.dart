import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keep_it_fresh/lib.dart';
import 'package:keep_it_fresh/pages/home_pages/widget/order_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.green,
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.green,
        title: SvgPicture.asset(
          Assets.icons.icFreshGo,
          width: 200.w,
          height: 150.w,
        ),
      ),
      drawer: Drawer(
        width: 230,
        child: ListView(
          children: [
            const SizedBox(
              height: 65,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.green,
                ),
                child: CommonText(
                  'Menu',
                  variant: Variant.h5,
                  textColor: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: const CommonText('Profile'),
              onTap: () {},
              trailing: SvgPicture.asset(Assets.icons.icProfile),
            ),
            ListTile(
              title: const CommonText('Your Orders'),
              onTap: () {},
              trailing: SvgPicture.asset(
                Assets.icons.icTruck,
                height: 25,
                width: 25,
              ),
            ),
            ListTile(
              title: const CommonText('Log Out'),
              onTap: () {},
              trailing: SvgPicture.asset(Assets.icons.icLogOut),
            )
          ],
        ),
      ),
      body: BlocProvider<OrderCubit>(
        create: (ctx) => OrderCubit()..getListOrders(1),
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            return state.maybeWhen(
              success: (data) {
                print('THIS IS ====== ${data}');
                return ListView.separated(
                    itemBuilder: ((context, index) => OrderCard(
                          order: data[index],
                        )),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 2,
                        ),
                    itemCount: data.length);
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
