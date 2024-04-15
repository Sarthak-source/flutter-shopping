

import 'package:hive/hive.dart';
part 'create_order.g.dart';


@HiveType(typeId: 0)
class CreateOrderModel {

  @HiveField(0)
  final String amtPaid;

  @HiveField(1)
  final String payMode;

  @HiveField(2)
  final String upiId;

  @HiveField(3)
  final String upiTransId;

  @HiveField(4)
  final String upiTransSts;

  @HiveField(5)
  final String shift;

  @HiveField(6)
  final String date;

  @HiveField(7)
  final String address;

  const CreateOrderModel(this.amtPaid, this.payMode, this.upiId,this.upiTransId, this.upiTransSts, this.shift, this.date, this.address);
}