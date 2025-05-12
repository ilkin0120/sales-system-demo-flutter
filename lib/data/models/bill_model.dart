import '../../domain/entities/bill_entity.dart';

class BillModel {
  final int seatId;
  final String seatName;
  final double total;

  const BillModel({
    required this.seatId,
    required this.seatName,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'seat_id': seatId,
      'seat_name': seatName,
      'total_bill': total,
    };
  }

  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      seatId: map['seat_id'],
      seatName: map['seat_name'],
      total: (map['total_bill'] ?? 0).toDouble(),
    );
  }

  factory BillModel.fromEntity(BillEntity entity) {
    return BillModel(
      seatId: entity.seatId,
      seatName: entity.seatName,
      total: entity.total,
    );
  }

  BillEntity toEntity() {
    return BillEntity(
      seatId: seatId,
      seatName: seatName,
      total: total,
    );
  }
} 