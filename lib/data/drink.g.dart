// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DrinkAdapter extends TypeAdapter<Drink> {
  @override
  final int typeId = 2;

  @override
  Drink read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Drink(
      image: fields[0] as String,
      title: fields[1] as String,
      subtitle: fields[2] as String,
      price: fields[3] as double,
      rate: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Drink obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subtitle)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.rate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrinkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
