part of 'cashier_cubit.dart';

enum CashierStatus { initial, loading, loaded, error }

class CashierState {
  final CashierStatus status;
  final List<BillEntity> seatsBills;
  final String? errorMessage;

  const CashierState({
    this.status = CashierStatus.initial,
    this.seatsBills = const [],
    this.errorMessage,
  });

  CashierState copyWith({
    CashierStatus? status,
    List<BillEntity>? seatsBills,
    String? errorMessage,
  }) {
    return CashierState(
      status: status ?? this.status,
      seatsBills: seatsBills ?? this.seatsBills,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
