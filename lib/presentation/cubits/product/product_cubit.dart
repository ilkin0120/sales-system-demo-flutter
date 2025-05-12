import 'package:bloc/bloc.dart';

import '../../../domain/entities/product_entity.dart';
import '../../../domain/entities/product_group_entity.dart';
import '../../../domain/usecases/get_product_groups_usecase.dart';
import '../../../domain/usecases/get_products_by_group_usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductGroupsUseCase _getProductGroupsUseCase;
  final GetProductsByGroupUseCase _getProductsByGroupUseCase;

  ProductCubit({
    required GetProductGroupsUseCase getProductGroupsUseCase,
    required GetProductsByGroupUseCase getProductsByGroupUseCase,
  })  : _getProductGroupsUseCase = getProductGroupsUseCase,
        _getProductsByGroupUseCase = getProductsByGroupUseCase,
        super(const ProductState());

  Future<void> getAllData() async {
    emit(state.copyWith(status: ProductStatus.loading));
    
    try {
      Map<ProductGroupEntity, List<ProductEntity>> result = {};
      final categories = await _getProductGroupsUseCase.execute();
      
      for (final category in categories) {
        final products = await _getProductsByGroupUseCase.execute(category.id!);
        result[category] = products;
      }
      
      emit(state.copyWith(
        status: ProductStatus.loaded,
        groupAndProducts: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
} 