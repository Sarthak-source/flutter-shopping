import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  Map productBody;
  // Add more fields as needed

  Product({required this.productBody});
}
