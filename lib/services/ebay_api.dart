import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:well_organized/constants/app_colors.dart';
import 'package:well_organized/constants/ebay_key.dart';
import 'package:well_organized/models/ebay_product_model.dart';

class EbayApi {
  final String scope = 'https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope';

  Future<EbayProductModel> getProductDataEbay(String upc) async {
    try {
      var postTokenResponse = await Dio().post(
        'https://api.ebay.com/identity/v1/oauth2/token',
        data: 'grant_type=client_credentials&scope=$scope',
        options: Options(
          headers: {
            'Authorization': EbayKey.ebayBasicKey,
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          sendTimeout: 5000,
          receiveTimeout: 5000,
        ),
      );
      final String accessToken = postTokenResponse.data['access_token'];

      var getDataResponse = await Dio().get(
        'https://api.ebay.com/buy/browse/v1/item_summary/search?gtin=$upc',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'X-EBAY-C-MARKETPLACE-ID': 'EBAY_US',
          },
          sendTimeout: 5000,
          receiveTimeout: 5000,
        ),
      );
      final data = (getDataResponse.data) as Map<String, dynamic>;
      //!if itemsummaries is null print causes error.
      // print(data['itemSummaries'][0]['thumbnailImages']);
      return EbayProductModel.fromMap(data);
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        textColor: AppColors.toastTextColor,
        backgroundColor: AppColors.toastBackgroundColor,
        toastLength: Toast.LENGTH_LONG,
      );
      print(e.message);
      rethrow;
    }
  }
}

final ebayApiProvider = Provider<EbayApi>((ref) => EbayApi());
final ebayProductProvider = FutureProvider.family.autoDispose<EbayProductModel, String>((ref, upc) async {
  return ref.watch(ebayApiProvider).getProductDataEbay(upc);
});
