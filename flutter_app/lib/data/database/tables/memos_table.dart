import 'package:drift/drift.dart';

class MemoEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get serverId => integer().nullable()();
  TextColumn get content => text()();
  TextColumn get petResponse => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}
