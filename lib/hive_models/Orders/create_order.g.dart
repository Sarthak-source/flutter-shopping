// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreateOrderModelAdapter extends TypeAdapter<CreateOrderModel> {
  @override
  final int typeId = 0;

  @override
  CreateOrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreateOrderModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CreateOrderModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.amtPaid)
      ..writeByte(1)
      ..write(obj.payMode)
      ..writeByte(2)
      ..write(obj.upiId)
      ..writeByte(3)
      ..write(obj.upiTransId)
      ..writeByte(4)
      ..write(obj.upiTransSts)
      ..writeByte(5)
      ..write(obj.shift)
      ..writeByte(6)
      ..write(obj.date)
      ..writeByte(7)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateOrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
