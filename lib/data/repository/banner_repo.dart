import 'package:flutter/material.dart';
import 'package:smartpond/data/datasource/remote/dio/dio_client.dart';
import 'package:smartpond/data/datasource/remote/exception/api_error_handler.dart';
import 'package:smartpond/data/model/response/base/api_response.dart';
import 'package:smartpond/utill/app_constants.dart';

class BannerRepo {
  final DioClient dioClient;
  BannerRepo({@required this.dioClient});

  Future<ApiResponse> getBannerList() async {
    try {
      final response = await dioClient.get(AppConstants.BANNER_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getProductDetails(String productID) async {
    try {
      final response =
          await dioClient.get('${AppConstants.PRODUCT_DETAILS_URI}$productID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
