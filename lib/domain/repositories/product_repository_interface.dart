import '../entities/product_entity.dart';
import '../entities/product_group_entity.dart';

abstract class IProductRepository {
  Future<List<ProductGroupEntity>> getProductGroups();
  Future<List<ProductEntity>> getProductsByGroup(int groupId);
} 