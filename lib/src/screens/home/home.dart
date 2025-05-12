import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/src/cubits/home/home_cubit.dart';
import 'package:test_task/core/route/route_names.dart';
import 'package:test_task/src/screens/home/widgets/hall_button.dart';
import 'package:test_task/src/screens/home/widgets/category.dart';

import '../sales/widgets/custom_drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Выбор'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.zoneAndSeatingAreas.isNotEmpty
                ? ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, zoneIndex) {
                      final zone =
                          state.zoneAndSeatingAreas.keys.toList()[zoneIndex];
                      final columnWidth =
                          MediaQuery.of(context).size.width / 2 - 20;

                      return SizedBox(
                        width: columnWidth,
                        child: CustomMultiChildLayout(
                          delegate: HomeLayoutDelegate(),
                          children: [
                            // Category title
                            LayoutId(
                              id: 'category',
                              child: Category(title: zone.name),
                            ),
                            // Halls list
                            LayoutId(
                              id: 'halls',
                              child: ListView.separated(
                                itemCount:
                                    state.zoneAndSeatingAreas[zone]!.length,
                                itemBuilder: (context, index) {
                                  final hall =
                                      state.zoneAndSeatingAreas[zone]![index];
                                  return HallButton(
                                      title: hall.name,
                                      icon: Icons.description,
                                      onClick: () {
                                        Navigator.pushNamed(
                                            context, RouteNames.sales,
                                            arguments: {
                                              'seatId': hall.id,
                                              'seatingTitle': hall.name
                                            });
                                      });
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 10);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    itemCount: state.zoneAndSeatingAreas.keys.length,
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class HomeLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  Size getSize(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  void performLayout(Size size) {
    Size categorySize = Size.zero;

    if (hasChild('category')) {
      categorySize = layoutChild(
        'category',
        BoxConstraints.loose(size),
      );
      positionChild('category', Offset.zero);
    }

    if (hasChild('halls')) {
      final hallsOffset = categorySize.height + 10;
      final remainingHeight = size.height - hallsOffset;

      final hallsSize = layoutChild(
        'halls',
        BoxConstraints(
          maxWidth: size.width,
          maxHeight: remainingHeight,
        ),
      );

      positionChild('halls', Offset(0, hallsOffset));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
