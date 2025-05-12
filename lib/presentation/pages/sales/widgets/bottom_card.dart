import 'package:flutter/material.dart';
import '../../../../domain/entities/product_entity.dart';

class BottomCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onClick;

  const BottomCard({
    super.key, 
    required this.product, 
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(4),
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    product.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          product.price.toString(),
                          style: const TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Склад: ${product.stock}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  product.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 