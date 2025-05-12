import 'package:bloc/bloc.dart';

import '../../../domain/entities/bill_entity.dart';
import '../../../domain/usecases/get_bills_usecase.dart';

part 'cashier_state.dart';

class CashierCubit extends Cubit<CashierState> {
  final GetBillsUseCase _getBillsUseCase;

  CashierCubit({
    required GetBillsUseCase getBillsUseCase,
  })  : _getBillsUseCase = getBillsUseCase,
        super(const CashierState());

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
}
