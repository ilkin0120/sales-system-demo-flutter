import '../../domain/entities/bill_entity.dart';
import '../../domain/repositories/cashier_repository_interface.dart';
import '../datasources/local/cashier_local_data_source.dart';

class CashierRepositoryImpl implements ICashierRepository {
  final CashierLocalDataSource localDataSource;

  CashierRepositoryImpl({required this.localDataSource});

  @override
  Future<List<BillEntity>> getBills() async {
    final billModels = await localDataSource.getBills();
    return billModels.map((model) => model.toEntity()).toList();
  }
} 