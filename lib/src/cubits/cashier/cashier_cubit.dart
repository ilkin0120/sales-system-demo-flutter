import 'package:bloc/bloc.dart';
import 'package:test_task/src/data/repositories/cashier_repository.dart';

import '../../data/models/bill.dart';

part 'cashier_state.dart';

class CashierCubit extends Cubit<CashierState> {
  final _cashierRepository = CashierRepository();

  CashierCubit() : super(CashierState(seatsBills: []));

  void getAllBills() async {
    final bills = await _cashierRepository.getBills();

    emit(state.copyWith(seatsBills: bills));
  }
}
