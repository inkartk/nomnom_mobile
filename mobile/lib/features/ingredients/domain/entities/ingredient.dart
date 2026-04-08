import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  final String id;
  final String name;
  final double quantity;
  final String unit;
  final DateTime expirationDate;

  const Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.expirationDate,
  });

  Ingredient copyWith({
    String? id,
    String? name,
    double? quantity,
    String? unit,
    DateTime? expirationDate,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  @override
  List<Object?> get props => [id, name, quantity, unit, expirationDate];
}
