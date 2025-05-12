import 'dart:async';

// Сервис для обновления информации о счетах столиков
class BillUpdateService {
  static final BillUpdateService _instance = BillUpdateService._internal();

  factory BillUpdateService() {
    return _instance;
  }

  BillUpdateService._internal();

  final _controller = StreamController<BillUpdate>.broadcast();

  Stream<BillUpdate> get stream => _controller.stream;

  void updateBill(int seatId, double total) {
    _controller.add(BillUpdate(seatId: seatId, total: total));
  }

  void dispose() {
    _controller.close();
  }
}

// Класс для хранения данных об обновлении счета
class BillUpdate {
  final int seatId;
  final double total;

  BillUpdate({required this.seatId, required this.total});
}
