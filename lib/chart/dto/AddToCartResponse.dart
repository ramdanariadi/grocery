import 'package:json_annotation/json_annotation.dart';
part 'AddToCartResponse.g.dart';

@JsonSerializable()
class AddToCartResponse {
  AddToCartData data;
  AddToCartResponse({required this.data});

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) =>
      _$AddToCartResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddToCartResponseToJson(this);
}

@JsonSerializable()
class AddToCartData {
  int totalItem;
  AddToCartData({required this.totalItem});

  factory AddToCartData.fromJson(Map<String, dynamic> json) =>
      _$AddToCartDataFromJson(json);
  Map<String, dynamic> toJson() => _$AddToCartDataToJson(this);
}
