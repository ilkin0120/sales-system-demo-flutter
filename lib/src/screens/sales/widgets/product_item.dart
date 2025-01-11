import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final double price;
  final int quantity;
  final VoidCallback onPlusClick;
  final VoidCallback onMinusClick;

  const ProductItem({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.onPlusClick,
    required this.onMinusClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                  maxLines: 2,
                ),
                Text(
                  'Цена: ${price * quantity}',
                  style: const TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.green),
                onPressed: onPlusClick,
              ),
              Text(quantity.toString()),
              IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.red),
                onPressed: onMinusClick,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
