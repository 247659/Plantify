import '../database.dart';

class EventsTable extends SupabaseTable<EventsRow> {
  @override
  String get tableName => 'events';

  @override
  EventsRow createRow(Map<String, dynamic> data) => EventsRow(data);
}

class EventsRow extends SupabaseDataRow {
  EventsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EventsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get eventDate => getField<DateTime>('event_date')!;
  set eventDate(DateTime value) => setField<DateTime>('event_date', value);

  String get eventName => getField<String>('event_name')!;
  set eventName(String value) => setField<String>('event_name', value);

  String get plantId => getField<String>('plant_id')!;
  set plantId(String value) => setField<String>('plant_id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  bool get done => getField<bool>('done')!;
  set done(bool value) => setField<bool>('done', value);

  bool? get isScheduled => getField<bool>('is_scheduled');
  set isScheduled(bool? value) => setField<bool>('is_scheduled', value);

  int? get scheduleMode => getField<int>('schedule_mode');
  set scheduleMode(int? value) => setField<int>('schedule_mode', value);

  String? get rootId => getField<String>('root_id');
  set rootId(String? value) => setField<String>('root_id', value);
}
