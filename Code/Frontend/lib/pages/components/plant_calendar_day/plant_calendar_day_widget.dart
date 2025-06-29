import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/empty_state/empty_state_widget.dart';
import '/pages/components/plant_calendar_bin_day/plant_calendar_bin_day_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'plant_calendar_day_model.dart';
export 'plant_calendar_day_model.dart';

class PlantCalendarDayWidget extends StatefulWidget {
  const PlantCalendarDayWidget({
    super.key,
    required this.date,
  });

  final DateTime? date;

  @override
  State<PlantCalendarDayWidget> createState() => _PlantCalendarDayWidgetState();
}

class _PlantCalendarDayWidgetState extends State<PlantCalendarDayWidget> {
  late PlantCalendarDayModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlantCalendarDayModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(),
            child: FutureBuilder<List<EventsRow>>(
              future: EventsTable().queryRows(
                queryFn: (q) => q
                    .eqOrNull(
                      'user_id',
                      currentUserUid,
                    )
                    .eqOrNull(
                      'event_date',
                      supaSerialize<DateTime>(widget!.date),
                    )
                    .not(
                      'root_id',
                      'is',
                      null,
                    ),
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                List<EventsRow> listViewEventsRowList = snapshot.data!;

                if (listViewEventsRowList.isEmpty) {
                  return Container(
                    width: double.infinity,
                    child: EmptyStateWidget(
                      icon: FaIcon(
                        FontAwesomeIcons.accessibleIcon,
                      ),
                      title: FFLocalizations.of(context).getText(
                        'c3m6ksxh' /* No event this day */,
                      ),
                      description: FFLocalizations.of(context).getText(
                        'socp423w' /* Add some events */,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listViewEventsRowList.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.0),
                  itemBuilder: (context, listViewIndex) {
                    final listViewEventsRow =
                        listViewEventsRowList[listViewIndex];
                    return PlantCalendarBinDayWidget(
                      key: Key(
                          'Key1gi_${listViewIndex}_of_${listViewEventsRowList.length}'),
                      event: listViewEventsRow,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
