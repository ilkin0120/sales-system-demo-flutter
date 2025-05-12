import '../entities/product_group_entity.dart';
import '../repositories/product_repository_interface.dart';

class GetProductGroupsUseCase {
  final IProductRepository repository;

  GetProductGroupsUseCase(this.repository);

  Future<List<ProductGroupEntity>> execute() {
    return repository.getProductGroups();
  }
} 