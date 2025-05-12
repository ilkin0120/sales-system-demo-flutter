import '../../domain/entities/bill_entity.dart';

class BillModel extends BillEntity {
  const BillModel({
    required super.seatId,
    required super.seatName,
    required super.total,
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