import 'package:json_annotation/json_annotation.dart';

part 'GetProduct.g.dart';

@JsonSerializable()
class GetProduct {
  int pageIndex;
  int pageSize;
  bool? isTop;
  bool? isRecommendation;
  String? categoryId;

  GetProduct({
    required this.pageIndex,
    required this.pageSize,
    this.isTop,
    this.isRecommendation,
    this.categoryId,
  });

  factory GetProduct.fromJson(Map<String, dynamic> json) =>
      _$GetProductFromJson(json);
  Map<String, dynamic> toJson() => _$GetProductToJson(this);
}

@JsonSerializable()
class GetProductResponse {
  List<SimpleProduct> data;
  int recordsTotal;
  int recordsFiltered;

  GetProductResponse(
      {required this.recordsTotal,
      required this.recordsFiltered,
      required this.data});

  factory GetProductResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetProductResponseToJson(this);
}

@JsonSerializable()
class SimpleProduct {
  String id;
  String name;
  String shopId;
  String shopName;
  int price;
  int weight;
  int perUnit;
  String description;
  String category;
  String? imageUrl;

  SimpleProduct({
    required this.id,
    required this.name,
    required this.shopId,
    required this.shopName,
    required this.price,
    required this.weight,
    required this.perUnit,
    required this.description,
    required this.category,
    this.imageUrl,
  });

  factory SimpleProduct.fromJson(Map<String, dynamic> json) =>
      _$SimpleProductFromJson(json);
  Map<String, dynamic> toJson() => _$SimpleProductToJson(this);
}
