import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../../core/services/bill_update_service.dart';
import '../../../domain/entities/bill_entity.dart';
import '../../../domain/usecases/get_bills_usecase.dart';

part 'cashier_state.dart';

class CashierCubit extends Cubit<CashierState> {
  final GetBillsUseCase _getBillsUseCase;
  final BillUpdateService _billUpdateService;
  StreamSubscription? _billUpdateSubscription;

  CashierCubit({
    required GetBillsUseCase getBillsUseCase,
    required BillUpdateService billUpdateService,
  })  : _getBillsUseCase = getBillsUseCase,
        _billUpdateService = billUpdateService,
        super(const CashierState()) {
    // Подписываемся на обновления счетов
    _billUpdateSubscription = _billUpdateService.stream.listen((update) {
      updateBill(update.seatId, update.total);
    });
  }

  @override
  Future<void> close() {
    // Отписываемся от стрима при закрытии кубита
    _billUpdateSubscription?.cancel();
    return super.close();
  }

  Future<void> getAllBills() async {
    emit(state.copyWith(status: CashierStatus.loading));

    try {
      final bills = await _getBillsUseCase.execute();
      emit(state.copyWith(
        status: CashierStatus.loaded,
        seatsBills: bills,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CashierStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // Метод для обновления счета конкретного столика без обращения к базе данных
  void updateBill(int seatId, double newTotal) {
    final updatedBills = state.seatsBills.map((bill) {
      if (bill.seatId == seatId) {
        return BillEntity(
          seatId: bill.seatId,
          seatName: bill.seatName,
          total: newTotal,
        );
      }
      return bill;
    }).toList();

    emit(state.copyWith(
      status: CashierStatus.loaded,
      seatsBills: updatedBills,
    ));
  }
}
