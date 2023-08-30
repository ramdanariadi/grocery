// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddToCartResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartResponse _$AddToCartResponseFromJson(Map<String, dynamic> json) =>
    AddToCartResponse(
      data: AddToCartData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddToCartResponseToJson(AddToCartResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

AddToCartData _$AddToCartDataFromJson(Map<String, dynamic> json) =>
    AddToCartData(
      totalItem: json['totalItem'] as int,
    );

Map<String, dynamic> _$AddToCartDataToJson(AddToCartData instance) =>
    <String, dynamic>{
      'totalItem': instance.totalItem,
    };
