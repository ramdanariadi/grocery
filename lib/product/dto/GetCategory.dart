import 'package:json_annotation/json_annotation.dart';

part 'GetCategory.g.dart';

@JsonSerializable()
class GetCategory {
  int pageIndex;
  int pageSize;

  GetCategory({required this.pageIndex, required this.pageSize});

  factory GetCategory.fromJson(Map<String, dynamic> json) =>
      _$GetCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$GetCategoryToJson(this);
}

@JsonSerializable()
class GetCategoryResponse {
  List<SimpleCategory> data;
  int recordsTotal;
  int recordsFiltered;

  GetCategoryResponse(
      {required this.recordsTotal,
      required this.recordsFiltered,
      required this.data});

  factory GetCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetCategoryResponseToJson(this);
}

@JsonSerializable()
class SimpleCategory {
  String id;
  String category;
  String imageUrl;

  SimpleCategory(
      {required this.id, required this.category, required this.imageUrl});

  factory SimpleCategory.fromJson(Map<String, dynamic> json) =>
      _$SimpleCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$SimpleCategoryToJson(this);
}
