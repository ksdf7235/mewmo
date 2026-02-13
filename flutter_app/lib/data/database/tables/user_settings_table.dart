import 'package:drift/drift.dart';

class UserSettingsEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverUrl => text().withDefault(const Constant(''))();
  BoolColumn get onboardingComplete =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get gachaComplete =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get namingComplete =>
      boolean().withDefault(const Constant(false))();
}
