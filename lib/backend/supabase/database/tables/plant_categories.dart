import '../database.dart';

class PlantCategoriesTable extends SupabaseTable<PlantCategoriesRow> {
  @override
  String get tableName => 'plant_categories';

  @override
  PlantCategoriesRow createRow(Map<String, dynamic> data) =>
      PlantCategoriesRow(data);
}

class PlantCategoriesRow extends SupabaseDataRow {
  PlantCategoriesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PlantCategoriesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get value => getField<String>('value');
  set value(String? value) => setField<String>('value', value);

  String? get valuePl => getField<String>('value_pl');
  set valuePl(String? value) => setField<String>('value_pl', value);
}
