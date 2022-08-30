import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:well_organized/constants/ebay_key.dart';

class EbayApi {
  final String scope = 'https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope';
  Future<void> getProductDataEbay(String upc) async {
    try {
      var postTokenResponse = await Dio().post(
        'https://api.ebay.com/identity/v1/oauth2/token',
        data: 'grant_type=client_credentials&scope=$scope',
        options: Options(headers: {
          'Authorization': EbayKey.ebayBasicKey,
          'Content-Type': 'application/x-www-form-urlencoded',
        }),
      );
      final String accessToken = postTokenResponse.data['access_token'];
      print(accessToken);

      var getDataResponse = await Dio().get(
        'https://api.ebay.com/buy/browse/v1/item_summary/search?gtin=$upc',
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
          'X-EBAY-C-MARKETPLACE-ID': 'EBAY_US',
        }),
      );
      //! product response shoud be a json object to use the data.
      print(getDataResponse.data);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
