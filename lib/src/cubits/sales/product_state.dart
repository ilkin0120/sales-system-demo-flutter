part of 'product_cubit.dart';

class ProductState {
  Map<ProductGroup, List<Product>> groupAndProducts;

  ProductState({required this.groupAndProducts});

  ProductState copyWith(
      {Map<ProductGroup, List<Product>>? groupAndProducts, L}) {
    return ProductState(
      groupAndProducts: groupAndProducts ?? this.groupAndProducts,
    );
  }
}
