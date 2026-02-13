import 'package:drift/drift.dart';

class PetEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get petType => text()(); // PetType.name (shiba, cheeseCat, etc.)
  TextColumn get petName => text().nullable()();
  TextColumn get petSound => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
