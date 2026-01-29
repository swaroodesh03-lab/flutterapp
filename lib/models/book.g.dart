// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
  id: json['id'] as String,
  title: json['title'] as String,
  slug: json['slug'] as String,
  pageCount: (json['pageCount'] as num).toInt(),
  basePrice: (json['basePrice'] as num).toDouble(),
  coverAssetPath: json['coverAssetPath'] as String,
  isActive: json['isActive'] as bool,
);

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'slug': instance.slug,
  'pageCount': instance.pageCount,
  'basePrice': instance.basePrice,
  'coverAssetPath': instance.coverAssetPath,
  'isActive': instance.isActive,
};
