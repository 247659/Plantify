import '../database.dart';

class EventsScheduleModesTable extends SupabaseTable<EventsScheduleModesRow> {
  @override
  String get tableName => 'events_schedule_modes';

  @override
  EventsScheduleModesRow createRow(Map<String, dynamic> data) =>
      EventsScheduleModesRow(data);
}

class EventsScheduleModesRow extends SupabaseDataRow {
  EventsScheduleModesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EventsScheduleModesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get mode => getField<String>('mode');
  set mode(String? value) => setField<String>('mode', value);

  String? get interval => getField<String>('interval');
  set interval(String? value) => setField<String>('interval', value);

  String? get modePl => getField<String>('mode_pl');
  set modePl(String? value) => setField<String>('mode_pl', value);

  String? get modeEn => getField<String>('mode_en');
  set modeEn(String? value) => setField<String>('mode_en', value);
}
