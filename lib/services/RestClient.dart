import 'package:dio/dio.dart';
import 'package:grocery/chart/dto/AddToCartResponse.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/product/dto/GetWishlistByProductResponse.dart';
import 'package:grocery/product/dto/UpdateWishlistResponse.dart';
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

  @POST("/wishlist/{productId}")
  Future<UpdateWishlistResponse> addToWishlist(@Path('productId') productId);

  @GET("/wishlist/{productId}")
  Future<GetWishlistByProductResponse> getWishListByProduct(
      @Path('productId') productId);

  @DELETE("/wishlist/{productId}")
  Future<UpdateWishlistResponse> removeFromWishlist(
      @Path('productId') productId);

  @POST("/cart/{productId}/{total}")
  Future<AddToCartResponse> addToCart(
      {@Path('productId') required String productId,
      @Path('total') required int total});
}
