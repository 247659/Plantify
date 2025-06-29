import '../database.dart';

class ListItemsTable extends SupabaseTable<ListItemsRow> {
  @override
  String get tableName => 'list_items';

  @override
  ListItemsRow createRow(Map<String, dynamic> data) => ListItemsRow(data);
}

class ListItemsRow extends SupabaseDataRow {
  ListItemsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ListItemsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  bool get status => getField<bool>('status')!;
  set status(bool value) => setField<bool>('status', value);

  String? get listId => getField<String>('list_id');
  set listId(String? value) => setField<String>('list_id', value);
}
