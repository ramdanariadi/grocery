// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetProduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProduct _$GetProductFromJson(Map<String, dynamic> json) => GetProduct(
      pageIndex: json['pageIndex'] as int,
      pageSize: json['pageSize'] as int,
      isTop: json['isTop'] as bool?,
      isRecommendation: json['isRecommendation'] as bool?,
      categoryId: json['categoryId'] as String?,
    );

Map<String, dynamic> _$GetProductToJson(GetProduct instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'isTop': instance.isTop,
      'isRecommendation': instance.isRecommendation,
      'categoryId': instance.categoryId,
    };

GetProductResponse _$GetProductResponseFromJson(Map<String, dynamic> json) =>
    GetProductResponse(
      recordsTotal: json['recordsTotal'] as int,
      recordsFiltered: json['recordsFiltered'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => SimpleProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetProductResponseToJson(GetProductResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
    };

SimpleProduct _$SimpleProductFromJson(Map<String, dynamic> json) =>
    SimpleProduct(
      id: json['id'] as String,
      name: json['name'] as String,
      shopId: json['shopId'] as String,
      shopName: json['shopName'] as String,
      price: json['price'] as int,
      weight: json['weight'] as int,
      perUnit: json['perUnit'] as int,
      description: json['description'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$SimpleProductToJson(SimpleProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'price': instance.price,
      'weight': instance.weight,
      'perUnit': instance.perUnit,
      'description': instance.description,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
    };
