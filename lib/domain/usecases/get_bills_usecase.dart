import '../entities/bill_entity.dart';
import '../repositories/cashier_repository_interface.dart';

class GetBillsUseCase {
  final ICashierRepository repository;

  GetBillsUseCase(this.repository);

  Future<List<BillEntity>> execute() {
    return repository.getBills();
  }
} 