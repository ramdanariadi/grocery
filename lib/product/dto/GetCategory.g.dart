// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCategory _$GetCategoryFromJson(Map<String, dynamic> json) => GetCategory(
      pageIndex: json['pageIndex'] as int,
      pageSize: json['pageSize'] as int,
    );

Map<String, dynamic> _$GetCategoryToJson(GetCategory instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
    };

GetCategoryResponse _$GetCategoryResponseFromJson(Map<String, dynamic> json) =>
    GetCategoryResponse(
      recordsTotal: json['recordsTotal'] as int,
      recordsFiltered: json['recordsFiltered'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => SimpleCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCategoryResponseToJson(
        GetCategoryResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
    };

SimpleCategory _$SimpleCategoryFromJson(Map<String, dynamic> json) =>
    SimpleCategory(
      id: json['id'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$SimpleCategoryToJson(SimpleCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
    };
