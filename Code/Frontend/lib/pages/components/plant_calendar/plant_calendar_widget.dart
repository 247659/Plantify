import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/components/empty_state/empty_state_widget.dart';
import '/pages/components/plant_calendar_bin/plant_calendar_bin_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'plant_calendar_model.dart';
export 'plant_calendar_model.dart';

class PlantCalendarWidget extends StatefulWidget {
  const PlantCalendarWidget({
    super.key,
    this.plant,
  });

  final PlantsRow? plant;

  @override
  State<PlantCalendarWidget> createState() => _PlantCalendarWidgetState();
}

class _PlantCalendarWidgetState extends State<PlantCalendarWidget> {
  late PlantCalendarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlantCalendarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: FlutterFlowChoiceChips(
                              options: [
                                ChipData(FFLocalizations.of(context).getText(
                                  'ht8m2vcu' /* Coming */,
                                )),
                                ChipData(FFLocalizations.of(context).getText(
                                  'q5br2vdx' /* Archival */,
                                ))
                              ],
                              onChanged: (val) => safeSetState(() =>
                                  _model.choiceChipsValue = val?.firstOrNull),
                              selectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context).info,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                iconColor: FlutterFlowTheme.of(context).info,
                                iconSize: 16.0,
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                iconColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                iconSize: 16.0,
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              chipSpacing: 8.0,
                              rowSpacing: 8.0,
                              multiselect: false,
                              initialized: _model.choiceChipsValue != null,
                              alignment: WrapAlignment.center,
                              controller: _model.choiceChipsValueController ??=
                                  FormFieldController<List<String>>(
                                [
                                  FFLocalizations.of(context).getText(
                                    't51lavwf' /* Coming */,
                                  )
                                ],
                              ),
                              wrapped: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if ((_model.choiceChipsValue == 'Coming') ||
                          (_model.choiceChipsValue == 'Nadchodzące'))
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: FutureBuilder<List<EventsRow>>(
                            future: EventsTable().queryRows(
                              queryFn: (q) => q
                                  .eqOrNull(
                                    'plant_id',
                                    widget!.plant?.id,
                                  )
                                  .gteOrNull(
                                    'event_date',
                                    supaSerialize<DateTime>(
                                        getCurrentTimestamp),
                                  )
                                  .not(
                                    'root_id',
                                    'is',
                                    null,
                                  )
                                  .order('event_date', ascending: true),
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
                              List<EventsRow> listViewEventsRowList =
                                  snapshot.data!;

                              if (listViewEventsRowList.isEmpty) {
                                return EmptyStateWidget(
                                  icon: FaIcon(
                                    FontAwesomeIcons.accessibleIcon,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24.0,
                                  ),
                                  title: FFLocalizations.of(context).getText(
                                    '0fk3zbyf' /* No actual events */,
                                  ),
                                  description:
                                      FFLocalizations.of(context).getText(
                                    'qo27vubp' /* Add yours events */,
                                  ),
                                );
                              }

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewEventsRowList.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewEventsRow =
                                      listViewEventsRowList[listViewIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 1.0, 0.0, 0.0),
                                    child: PlantCalendarBinWidget(
                                      key: Key(
                                          'Keyzm4_${listViewIndex}_of_${listViewEventsRowList.length}'),
                                      event: listViewEventsRow,
                                      plant: widget!.plant,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if ((_model.choiceChipsValue == 'Archival') ||
                        (_model.choiceChipsValue == 'Archiwalne'))
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FutureBuilder<List<EventsRow>>(
                          future: EventsTable().queryRows(
                            queryFn: (q) => q
                                .eqOrNull(
                                  'plant_id',
                                  widget!.plant?.id,
                                )
                                .ltOrNull(
                                  'event_date',
                                  supaSerialize<DateTime>(getCurrentTimestamp),
                                )
                                .not(
                                  'root_id',
                                  'is',
                                  null,
                                )
                                .order('event_date', ascending: true),
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
                            List<EventsRow> listViewEventsRowList =
                                snapshot.data!;

                            if (listViewEventsRowList.isEmpty) {
                              return EmptyStateWidget(
                                icon: FaIcon(
                                  FontAwesomeIcons.accessibleIcon,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 24.0,
                                ),
                                title: FFLocalizations.of(context).getText(
                                  'v3kzuu3y' /* No archival events */,
                                ),
                                description:
                                    FFLocalizations.of(context).getText(
                                  'itx5xlzw' /* Add yours events */,
                                ),
                              );
                            }

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewEventsRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewEventsRow =
                                    listViewEventsRowList[listViewIndex];
                                return PlantCalendarBinWidget(
                                  key: Key(
                                      'Keyyvx_${listViewIndex}_of_${listViewEventsRowList.length}'),
                                  event: listViewEventsRow,
                                  plant: widget!.plant,
                                );
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: AlignmentDirectional(1.0, 1.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 16.0),
            child: FloatingActionButton(
              onPressed: () async {
                context.pushNamed(
                  AddCalendarWidget.routeName,
                  queryParameters: {
                    'plant': serializeParam(
                      widget!.plant,
                      ParamType.SupabaseRow,
                    ),
                  }.withoutNulls,
                );
              },
              backgroundColor: FlutterFlowTheme.of(context).primary,
              elevation: 8.0,
              child: Icon(
                Icons.add_rounded,
                color: FlutterFlowTheme.of(context).info,
                size: 36.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
