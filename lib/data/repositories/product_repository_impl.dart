import '../../domain/entities/product_entity.dart';
import '../../domain/entities/product_group_entity.dart';
import '../../domain/repositories/product_repository_interface.dart';
import '../datasources/local/product_local_data_source.dart';

class ProductRepositoryImpl implements IProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ProductGroupEntity>> getProductGroups() async {
    final productGroupModels = await localDataSource.getProductGroups();
    return productGroupModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<ProductEntity>> getProductsByGroup(int groupId) async {
    final productModels = await localDataSource.getProductsByGroup(groupId);
    return productModels.map((model) => model.toEntity()).toList();
  }
} 