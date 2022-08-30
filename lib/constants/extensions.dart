import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_product_model.dart';

extension FindingZeroQuantityProducts on List<QueryDocumentSnapshot<Map<String, dynamic>>> {
  isNotZero() => where((element) => AppProductModel.fromMap(element.data()).quantity > 0);
}
