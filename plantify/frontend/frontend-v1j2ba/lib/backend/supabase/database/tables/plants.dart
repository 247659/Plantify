import '../database.dart';

class PlantsTable extends SupabaseTable<PlantsRow> {
  @override
  String get tableName => 'plants';

  @override
  PlantsRow createRow(Map<String, dynamic> data) => PlantsRow(data);
}

class PlantsRow extends SupabaseDataRow {
  PlantsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PlantsTable();

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get location => getField<String>('location');
  set location(String? value) => setField<String>('location', value);

  String? get photoUrl => getField<String>('photo_url');
  set photoUrl(String? value) => setField<String>('photo_url', value);

  String? get species => getField<String>('species');
  set species(String? value) => setField<String>('species', value);

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get category => getField<String>('category')!;
  set category(String value) => setField<String>('category', value);
}
