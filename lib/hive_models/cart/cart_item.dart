import 'package:hive/hive.dart';
import 'package:sutra_ecommerce/hive_models/product/product_model.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  int count;

  @HiveField(1)
  Product product;

  CartItem({required this.count, required this.product});
}
