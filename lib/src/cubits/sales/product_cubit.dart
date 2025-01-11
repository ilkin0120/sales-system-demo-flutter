import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_task/src/data/models/product.dart';
import 'package:test_task/src/data/models/product_group.dart';

import '../../data/repositories/product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final _productRepository = ProductRepository();

  ProductCubit() : super(ProductState(groupAndProducts: {}));

  void getAllData() async {
    Map<ProductGroup, List<Product>> result = {};
    final categories = await _productRepository.fetchGroups();
    for (final category in categories) {
      final products =
          await _productRepository.fetchProductsByGroup(category.id!);
      result[category] = products;
    }
    emit(state.copyWith(groupAndProducts: result));
  }
}
