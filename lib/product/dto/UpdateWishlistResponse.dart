import 'package:json_annotation/json_annotation.dart';

part 'UpdateWishlistResponse.g.dart';

@JsonSerializable()
class UpdateWishlistResponse {
  UpdateWishlistResponse();

  factory UpdateWishlistResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateWishlistResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateWishlistResponseToJson(this);
}
