import 'package:dio/dio.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/product/dto/GetCategory.dart';
import 'package:grocery/product/dto/GetProduct.dart';
import 'package:retrofit/retrofit.dart';
part 'RestClient.g.dart';

@RestApi(baseUrl: Application.httBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET("/category")
  Future<GetCategoryResponse> fetchCategory(
      @Queries(encoded: true) GetCategory query);

  @GET("/product")
  Future<GetProductResponse> fetchProduct(
      @Queries(encoded: true) GetProduct query);
}
