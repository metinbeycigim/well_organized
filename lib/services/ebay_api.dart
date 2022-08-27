import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class EbayApi {
  Future<void> getToken() async {
    try {
      var response = await Dio().post(
        'https://api.ebay.com/identity/v1/oauth2/token',
        data: 'grant_type=client_credentials&scope=https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope',
        options: Options(headers: {
          'Authorization':
              'Basic TWV0aW5CYXktcHJpY2VjaGUtUFJELTEyOTJmMjViNy1iMzczY2NhNzpQUkQtMjkyZjI1YjdiODliLWY3MzItNGI1MC1hNjZmLTliZjU=',
          'Content-Type': 'application/x-www-form-urlencoded',
        }),
      );
      print(response.data);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> getProductByUpc(String upc) async {
    try {
      var response = await Dio().get(
        'https://api.ebay.com/buy/browse/v1/item_summary/search?gtin=$upc',
        options: Options(headers: {
          'Authorization':
              'Bearer v^1.1#i^1#r^0#I^3#f^0#p^1#t^H4sIAAAAAAAAAOVYbWgURxjOXi6xMUYpFWttS9NVS2t7e7Mfud1bvaOXxNQTY07vFE0R3Y/ZuLq3u9mZMzm/iBFsa7UgCPZHKwERjfqjFvtDKqXSD0EoBTFWDUg1WgvaQiu1xdKP3c2Hl1TUmoMGen+Oeeedd57nmfedmR3QUV4xa9u8bb9WEeMCXR2gI0AQdCWoKC97eWJpYFpZCShwILo6ZnQEO0u/n4OkrGGLiyGyLRPB6vasYSLRN8bInGOKloR0JJpSFiIRK2I60bhAZCgg2o6FLcUyyOpkfYyMwKiiCRwTUWSZU4WoazUHY2asGMlDngc0q3IKz/CAi7j9COVg0kRYMnGMZADDhIAQYvgMw4g0J3JRiha4ZrJ6KXSQbpmuCwXIuA9X9Mc6BVjvD1VCCDrYDULGk4mGdFMiWT93YWZOuCBWfECHNJZwDg1v1VkqrF4qGTl4/2mQ7y2mc4oCESLD8f4ZhgcVE4NgHgG+LzWsURSWpmVVAEKUV4qiZIPlZCV8fxieRVdDmu8qQhPrOP8gQV0x5DVQwQOthW6IZH2197coJxm6pkMnRs6tTSxPpFJkvBFi3ayV8iHb0RWorIah1OL6EM1EGY2pkfmQzPKsokj8wET90QZUHjFTnWWquqcZql5o4VroooYjtQEF2rhOTWaTk9Cwh2jIT8gAMKgh7/qFBxcxh1eb3rLCrCtEtd988AoMjcbY0eUchkMRRnb4EsVIybZ1lRzZ6afiQPa0oxi5GmNbDIfb2tqoNpaynJYwAwAdXta4IO1qmJVIz9erdd9ff/CAkO5TUaA7EukiztsulnY3VV0AZgsZ52p4QRhcheGw4iOt/zAUcA4PL4hiFQinyqpUowgaJ/EshHIxKiQ+kKRhDweU3RzNSs5aiG1DUmBIcfMsl4WOropsjcawggZDaiSqhbiopoXkGjUSojUIgQtGVqLC/6lQHjbV01BxIC5Orhcrz+fT9YqUzudyLGhfomotDpivsVLza4KVMLDcXEdn08vWa22smrdiD1sN9yRfZ+iuMhl3/qII4NV60USYZyEM1VHRSyuWDVOWoSv5sbXArKOmJAfn09AwXMOoSCZsO1mkvbpY9P7lNvFovIt4Rv0359M9WSEvZccWK288cgNItk55JxClWNmw5dW65F4/PPNKH/WoeOvuxXVMsXZJ9rPV1f4rJ2V5dCm0TqEciKyc4162qSbvBpax1kLTPc+wYxkGdJbSo67nbDaHJdmAY62wi5DgujTGDls6EqEjrMAJ0VHxUvyjdOVY25KKshUHGx7tWh0e/o0fL/F/dCfxEegkjgYIAoTBTHo6eL68dEmwdMI0pGNI6ZJGIb3FdD9dHUithXlb0p1AObG5UVzUU/Cq0LUCTB16V6gopSsLHhnAM3d7yuhJT1YxDBAYnmFojos2g+l3e4P0lODkvnMTDk25GtlhxZ+eZNUyB9858zUBqoacCKKsJNhJlNRewMSmy1OOnV4vfPdn8jE0Q+3bdNKZfaN1z5sXLpzcdeLTGcdLWoWNN07f/mYJ9fh+ujWYWrd3F3Opu4cIqhcnWZ+cvZJ59lDpFyWNW7r37H575h+9xldvbf5843n79o7AzQPNP71x5Mr5fXP3wTOX9x9nbt0e19q04ZUDe1qITR9OIN7+bcW0BLjW98vy3vfeF16g63q08RePrZpY4SSuVyXnfMxmtl/bTvbpe4+syqxYU9Zl7tww/rPXs0+l/7rz4qnK7peeq204fOjgPu3HyhNHp97p7D0X3XK1993ySzfOfnDq5s+BH3rh7tbZbWu2piJXr//eXtXz6rdPdH95Z52+fGtX5+Fbsya3Xt7Zv3x/A6JiDQDvEQAA',
          'Content-Type': 'application/json',
          'X-EBAY-C-MARKETPLACE-ID': 'EBAY_US',
        }),
      );
      // print(token);
      print(response.data);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
