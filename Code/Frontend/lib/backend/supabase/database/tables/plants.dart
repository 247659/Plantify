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

  String? get ownerId => getField<String>('owner_id');
  set ownerId(String? value) => setField<String>('owner_id', value);

  String? get wateringEng => getField<String>('watering_eng');
  set wateringEng(String? value) => setField<String>('watering_eng', value);

  String? get sunlightEng => getField<String>('sunlight_eng');
  set sunlightEng(String? value) => setField<String>('sunlight_eng', value);

  String? get pruningEng => getField<String>('pruning_eng');
  set pruningEng(String? value) => setField<String>('pruning_eng', value);

  String? get fertilizationEng => getField<String>('fertilization_eng');
  set fertilizationEng(String? value) =>
      setField<String>('fertilization_eng', value);

  String? get wateringPl => getField<String>('watering_pl');
  set wateringPl(String? value) => setField<String>('watering_pl', value);

  String? get sunlightPl => getField<String>('sunlight_pl');
  set sunlightPl(String? value) => setField<String>('sunlight_pl', value);

  String? get pruningPl => getField<String>('pruning_pl');
  set pruningPl(String? value) => setField<String>('pruning_pl', value);

  String? get fertilizationPl => getField<String>('fertilization_pl');
  set fertilizationPl(String? value) =>
      setField<String>('fertilization_pl', value);

  int get category => getField<int>('category')!;
  set category(int value) => setField<int>('category', value);
}
