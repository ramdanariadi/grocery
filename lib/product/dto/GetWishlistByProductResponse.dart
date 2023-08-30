import 'package:json_annotation/json_annotation.dart';
part 'GetWishlistByProductResponse.g.dart';

@JsonSerializable()
class GetWishlistByProductResponse {
  WishlistByProduct? data;

  GetWishlistByProductResponse({this.data});

  factory GetWishlistByProductResponse.fromJson(Map<String, dynamic> json) =>
      _$GetWishlistByProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetWishlistByProductResponseToJson(this);
}

@JsonSerializable()
class WishlistByProduct {
  String id;
  String name;
  int price;
  int weight;
  int perUnit;
  String description;
  String category;
  String? imageUrl;

  WishlistByProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.weight,
    required this.perUnit,
    required this.description,
    required this.category,
    this.imageUrl,
  });

  factory WishlistByProduct.fromJson(Map<String, dynamic> json) =>
      _$WishlistByProductFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistByProductToJson(this);
}
