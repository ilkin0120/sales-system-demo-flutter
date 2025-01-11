part of 'cashier_cubit.dart';

class CashierState {
  List<Bill> seatsBills;

  CashierState({required this.seatsBills});

  CashierState copyWith({List<Bill>? seatsBills}) {
    return CashierState(seatsBills: seatsBills ?? this.seatsBills);
  }
}
