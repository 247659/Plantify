import '../database.dart';

class PlantsProfilesTable extends SupabaseTable<PlantsProfilesRow> {
  @override
  String get tableName => 'plants_profiles';

  @override
  PlantsProfilesRow createRow(Map<String, dynamic> data) =>
      PlantsProfilesRow(data);
}

class PlantsProfilesRow extends SupabaseDataRow {
  PlantsProfilesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PlantsProfilesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get plantId => getField<String>('plant_id')!;
  set plantId(String value) => setField<String>('plant_id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String get ownerId => getField<String>('owner_id')!;
  set ownerId(String value) => setField<String>('owner_id', value);
}
