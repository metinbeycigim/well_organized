import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

extension FindingZeroQuantityProducts on List<QueryDocumentSnapshot<Map<String, dynamic>>> {
  zeroQuantityProducts() => where((element) => ProductModel.fromMap(element.data()).quantity > 0);
}
