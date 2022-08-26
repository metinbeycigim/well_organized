import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class EbayApi {
  Future<void> getProductByUpc(String upc) async {
    try {
      var response = await Dio().get(
        'https://api.ebay.com/buy/browse/v1/item_summary/search?gtin=$upc',
        options: Options(headers: {
          'Authorization':
              'Bearer v^1.1#i^1#f^0#I^3#r^0#p^1#t^H4sIAAAAAAAAAOVYfWzUZBjfbbfhxgBBIoYoOQtqArbXvu19ddzJbWPsdNvduHOwJUh67dtdXa/t2rf7wI8sC1+CITgVoghZiP6FRgFRJGAMhgSMCsYoRhIkaowgxgSMDgNq231wmwSQXeIS759Ln/d5n/f3+z3P875vS/aUlM5fW7v29ymuSYX9PWRPoctFTSZLS4oXTC0qnF1cQOY4uPp75vW4e4t+XGhwWVljl0JDUxUDerqysmKwjjGMmbrCqpwhGazCZaHBIp5NRuvrWECQrKarSOVVGfPEqsMYYGgISIb0i4Lfz1OWURkOmVLDmI+mQ2IAApphBB8IhKxxwzBhTDEQpyBrOgkATgZx4E8BwIIAywSJIMO0YJ4mqBuSqlguBIlFHLSsM1fPgXp9pJxhQB1ZQbBILFqTjEdj1YsbUgu9ObEiQzIkEYdMY/RTlSpATxMnm/D6yxiON5s0eR4aBuaNDK4wOigbHQZzC/AdpQVA+hiR81F0mgLpNMiLlDWqnuXQ9XHYFknARceVhQqSUPeNFLXUSD8OeTT01GCFiFV77L9Gk5MlUYJ6GFtcGW2OJhJYpB4iSankunFNl3jIZyCeWFqNUyAEROBLB/A0HaB5ngsMLTQYbUjmMStVqYog2aIZngYVVUILNRyrDZWjjeUUV+J6VEQ2ohG/QIokhzWkQy12UgezaKKMYucVZi0hPM7jjTMwMhshXUqbCI5EGDvgSBTGOE2TBGzsoFOLQ+XTZYSxDEIa6/V2dnYSnTSh6q1eQJKUd3l9XdLSMMthtq/d646/dOMJuORQ4aE105BY1K1ZWLqsWrUAKK1YhPEFgsHhLIyGFRlr/Ychh7N3dEfkq0NoEXACoLggycNQiPflo0MiQ0XqtXHAtFWjWU5vg0iTOR7ivFVnZhbqksDSPhHQQRHigj8k4kxIFPG0T/DjlAghCWE6zYeC/6dGudlST0Jehyg/tZ6vOo8/nGrnFsRbYx1RurJBaBQ7auSo2YXqM8uijNRcYwrqqrrGBOSXtoVvthuuSb5KlixlUtb6eRHA7vW8iVCrGggK46KX5FUNJlRZ4rsnVoJpXUhwOupOQlm2DOMiGdW0WJ726nzR+5fbxK3xzuMZ9d+cT9dkZdglO7FY2fMNKwCnSYR9AhG8mvWqdq9z1vXDNq90UI+Lt2TdXCcUa4vkIFtJGLxyEqpNlzA6eEKHhmrq1m2biNs3sJTaBhXrPEO6KstQb6LG3c/ZrIm4tAwnWmPnocAlboIdtpTfT/l8IOgPjosX7xylKyfalpSXrdhdc2vXau/od/xIgfOjel37yF7X7kKXi/SS91FzyXtLih51F5XPNiQECYkTCUNqVax3Vx0SbbBb4yS9sMT1dD3b+EXOV4X+FeRdI98VSouoyTkfGci7r44UU9NmTQGADAI/ACDABFvIuVdH3dSd7pnalq/7Trc9tuNQ3alpc859/mxf6TsvklNGnFyu4gJ3r6sgcKjxyk+7en5NVOw/WuZWyz56jt3zxv6T2w6Xn+4Mz7ht2bFXt1XvWfvh2dn75z54btHHR15b85Br+4VHBo61tPdtmsP2Mmf3rVpdfiAqDMyb1bD3m8O1x923Tyf76el/HDg4UFG70xT/WvIturz7yXe9vZ7vLxHMxsySLZsv9p+etrP29befF+nKNUePlG6es+qrQ8+81OTuiN+/64N156/AzOWnNlw60Z90//DLmfV9+BP3ZHZc7A0MlF2JPLDzlYrGsjNbyfN3lOOr297c9ed7M+YdXLF7+c9T24PNmVnH5wfat75P+cGXW6pe8Hk/6Xxr+6kVJz/7rnlhbINv5okLL69btFfZ9Jv/U74iOWn9YPr+BllejcvvEQAA',
          'Content-Type': 'application/json',
          'X-EBAY-C-MARKETPLACE-ID': 'EBAY_US',
        }),
      );

      print(response.data);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
