// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetWishlistByProductResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWishlistByProductResponse _$GetWishlistByProductResponseFromJson(
        Map<String, dynamic> json) =>
    GetWishlistByProductResponse(
      data: json['data'] == null
          ? null
          : WishlistByProduct.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetWishlistByProductResponseToJson(
        GetWishlistByProductResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

WishlistByProduct _$WishlistByProductFromJson(Map<String, dynamic> json) =>
    WishlistByProduct(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      weight: json['weight'] as int,
      perUnit: json['perUnit'] as int,
      description: json['description'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$WishlistByProductToJson(WishlistByProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'weight': instance.weight,
      'perUnit': instance.perUnit,
      'description': instance.description,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
    };
