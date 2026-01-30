import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  final String id;
  final String title;
  final String slug;
  final int pageCount;
  final double basePrice;
  final String coverAssetPath;
  final bool isActive;

  Book({
    required this.id,
    required this.title,
    required this.slug,
    required this.pageCount,
    required this.basePrice,
    required this.coverAssetPath,
    required this.isActive,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
