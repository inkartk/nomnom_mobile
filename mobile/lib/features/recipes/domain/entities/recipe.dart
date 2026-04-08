import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> instructions;
  final String imageUrl;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.instructions,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, description, instructions, imageUrl];
}
