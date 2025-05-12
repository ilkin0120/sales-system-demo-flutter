part of 'product_cubit.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductState {
  final ProductStatus status;
  final Map<ProductGroupEntity, List<ProductEntity>> groupAndProducts;
  final String? errorMessage;

  const ProductState({
    this.status = ProductStatus.initial,
    this.groupAndProducts = const {},
    this.errorMessage,
  });

  ProductState copyWith({
    ProductStatus? status,
    Map<ProductGroupEntity, List<ProductEntity>>? groupAndProducts,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      groupAndProducts: groupAndProducts ?? this.groupAndProducts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
} 