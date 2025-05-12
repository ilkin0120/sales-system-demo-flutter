import '../entities/product_entity.dart';
import '../repositories/product_repository_interface.dart';

class GetProductsByGroupUseCase {
  final IProductRepository repository;

  GetProductsByGroupUseCase(this.repository);

  Future<List<ProductEntity>> execute(int groupId) {
    return repository.getProductsByGroup(groupId);
  }
} 