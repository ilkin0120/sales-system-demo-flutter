import '../entities/bill_entity.dart';

abstract class ICashierRepository {
  Future<List<BillEntity>> getBills();
} 