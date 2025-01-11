import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/src/cubits/orders/order_cubit.dart';
import 'package:test_task/src/cubits/sales/product_cubit.dart';
import 'package:test_task/src/screens/sales/widgets/bottom_search.dart';
import 'bottom_card.dart';
import 'group_box.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int seatingAreaId;
  final double screenHeight;

  const CustomBottomNavigationBar(
      {super.key, required this.screenHeight, required this.seatingAreaId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final groupBoxWidth = screenWidth / 2 - 20;
    return SizedBox(
      height: screenHeight / 2,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
          child: Column(
            children: [
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  return state.groupAndProducts.isNotEmpty
                      ? SizedBox(
                          height: screenHeight / 2 - 70,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.groupAndProducts.length,
                            itemBuilder: (context, groupIndex) {
                              return SizedBox(
                                height: screenHeight / 2 - 80 - 100,
                                child: Column(
                                  children: [
                                    GroupBox(
                                        groupBoxWidth: groupBoxWidth,
                                        title: state.groupAndProducts.keys
                                            .toList()[groupIndex]
                                            .name),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      height: screenHeight / 2 - 80 - 110,
                                      width: groupBoxWidth,
                                      child: Center(
                                        child: ListView.separated(
                                          itemCount: state
                                              .groupAndProducts.values
                                              .toList()[groupIndex]
                                              .length,
                                          itemBuilder: (context, index) {
                                            final product = state
                                                .groupAndProducts.values
                                                .toList()[groupIndex][index];
                                            return BottomCard(
                                              onClick: () {
                                                context
                                                    .read<OrderCubit>()
                                                    .addNewOrder(
                                                        product.id!,
                                                        seatingAreaId,
                                                        product.name,
                                                        product.price);
                                              },
                                              product: product,
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(
                                              height: 15,
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (widget, index) {
                              return const SizedBox(
                                width: 20,
                              );
                            },
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
              const SizedBox(
                height: 58,
                child: BottomSearch(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
