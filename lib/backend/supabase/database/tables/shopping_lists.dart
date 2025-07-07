import '../database.dart';

class ShoppingListsTable extends SupabaseTable<ShoppingListsRow> {
  @override
  String get tableName => 'shopping_lists';

  @override
  ShoppingListsRow createRow(Map<String, dynamic> data) =>
      ShoppingListsRow(data);
}

class ShoppingListsRow extends SupabaseDataRow {
  ShoppingListsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ShoppingListsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get plantId => getField<String>('plant_id');
  set plantId(String? value) => setField<String>('plant_id', value);
}
