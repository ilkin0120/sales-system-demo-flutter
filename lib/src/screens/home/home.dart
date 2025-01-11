import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/src/cubits/home/home_cubit.dart';
import 'package:test_task/src/route/route_names.dart';
import 'package:test_task/src/screens/home/widgets/hall_button.dart';
import 'package:test_task/src/screens/home/widgets/category.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height - 88;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
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

                        return SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 20 ,
                          child: Column(
                            children: [
                              Category(title: zone.name),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: screenHeight - 90,
                                width: double.infinity,
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
                                              arguments: {'seatId': hall.id});
                                        });
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: state.zoneAndSeatingAreas.keys.length,
                    )
                  : const SizedBox.shrink();
            },
          )),
    );
  }
}
