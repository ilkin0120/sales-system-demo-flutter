class Bill {
  final int seatId;
  final String seatName;
  final double total;

  Bill({required this.seatId, required this.seatName, required this.total});

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      seatId: map['seat_id'],
      seatName: map['seat_name'],
      total: map['total_bill'] ?? 0,
    );
  }
}
