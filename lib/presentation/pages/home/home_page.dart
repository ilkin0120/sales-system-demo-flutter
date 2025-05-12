import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/seating_area_entity.dart';
import '../../../domain/entities/zone_entity.dart';
import '../../cubits/home/home_cubit.dart';
import '../../../core/route/route_names.dart';
import 'widgets/hall_button.dart';
import 'widgets/category.dart';
import '../../widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getAllData();
  }

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
            if (state.status == HomeStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == HomeStatus.error) {
              return Center(
                child: Text('Ошибка: ${state.errorMessage}'),
              );
            } else if (state.status == HomeStatus.loaded) {
              return _buildContent(context, state.zoneAndSeatingAreas);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Map<ZoneEntity, List<SeatingAreaEntity>> zoneAndSeatingAreas) {
    return zoneAndSeatingAreas.isNotEmpty
        ? ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, zoneIndex) {
              final zone = zoneAndSeatingAreas.keys.toList()[zoneIndex];
              final columnWidth = MediaQuery.of(context).size.width / 2 - 20;

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
                        itemCount: zoneAndSeatingAreas[zone]!.length,
                        itemBuilder: (context, index) {
                          final hall = zoneAndSeatingAreas[zone]![index];
                          return HallButton(
                            title: hall.name,
                            icon: Icons.description,
                            onClick: () {
                              Navigator.pushNamed(
                                context, 
                                RouteNames.sales,
                                arguments: {
                                  'seatId': hall.id,
                                  'seatingTitle': hall.name
                                },
                              );
                            },
                          );
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
            itemCount: zoneAndSeatingAreas.keys.length,
          )
        : const Center(child: Text('Нет доступных зон'));
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