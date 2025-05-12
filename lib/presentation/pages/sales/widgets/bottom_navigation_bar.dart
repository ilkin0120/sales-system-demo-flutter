import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/order/order_cubit.dart';
import '../../../cubits/product/product_cubit.dart';
import 'bottom_card.dart';
import 'group_box.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int seatingAreaId;
  final double screenHeight;

  const CustomBottomNavigationBar({
    super.key,
    required this.screenHeight,
    required this.seatingAreaId,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight / 2,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state.status == ProductStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == ProductStatus.error) {
                return Center(child: Text('Ошибка: ${state.errorMessage}'));
              } else if (state.groupAndProducts.isEmpty) {
                return const Center(child: Text('Нет продуктов'));
              }
              
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.groupAndProducts.length,
                itemBuilder: (context, groupIndex) {
                  return CustomMultiChildLayout(
                    delegate: MyCustomLayoutDelegate(),
                    children: [
                      LayoutId(
                        id: 'top',
                        child: GroupBox(
                          title: state.groupAndProducts.keys
                            .toList()[groupIndex]
                            .name,
                        ),
                      ),
                      LayoutId(
                        id: 'list',
                        child: Center(
                          child: ListView.separated(
                            itemCount: state.groupAndProducts.values
                                .toList()[groupIndex]
                                .length,
                            itemBuilder: (context, index) {
                              final product = state
                                  .groupAndProducts.values
                                  .toList()[groupIndex][index];
                              return BottomCard(
                                onClick: () {
                                  context.read<OrderCubit>().addNewOrder(
                                    product.id!,
                                    seatingAreaId,
                                    product.name,
                                    product.price,
                                  );
                                },
                                product: product,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 15);
                            },
                          ),
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (widget, index) {
                  return const SizedBox(width: 20);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyCustomLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  Size getSize(BoxConstraints constraints) {
    return const Size(140, 400); // Размер основного контейнера
  }

  @override
  void performLayout(Size size) {
    Size topSize = Size.zero;

    // Размещаем верхний элемент ('top')
    if (hasChild('top')) {
      topSize = layoutChild(
        'top',
        BoxConstraints.loose(const Size(140, 100)),
      );

      // Позиционируем 'top' элемент вверху
      positionChild('top', Offset.zero);
    }

    // Вычисляем оставшуюся высоту для списка с учетом промежутка 15
    final listTopOffset = topSize.height + 15;
    final remainingHeight = size.height - listTopOffset;

    // Размещаем список ('list')
    if (hasChild('list')) {
      layoutChild(
        'list',
        BoxConstraints(
          maxWidth: size.width,
          maxHeight: remainingHeight, // Оставшаяся высота
        ),
      );

      // Позиционируем 'list' элемент с учетом высоты top и промежутка 15
      positionChild('list', Offset(0, listTopOffset));
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
} 