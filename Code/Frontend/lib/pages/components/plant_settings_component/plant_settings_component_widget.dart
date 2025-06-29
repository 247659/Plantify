import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/invite_friend/invite_friend_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'plant_settings_component_model.dart';
export 'plant_settings_component_model.dart';

class PlantSettingsComponentWidget extends StatefulWidget {
  const PlantSettingsComponentWidget({
    super.key,
    required this.plantRef,
    bool? isEditing,
  }) : this.isEditing = isEditing ?? false;

  final PlantsRow? plantRef;
  final bool isEditing;

  @override
  State<PlantSettingsComponentWidget> createState() =>
      _PlantSettingsComponentWidgetState();
}

class _PlantSettingsComponentWidgetState
    extends State<PlantSettingsComponentWidget> {
  late PlantSettingsComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlantSettingsComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 400.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                    child: Container(
                      width: 50.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder<List<PlantsProfilesRow>>(
                future: PlantsProfilesTable().querySingleRow(
                  queryFn: (q) => q
                      .eqOrNull(
                        'user_id',
                        currentUserUid,
                      )
                      .eqOrNull(
                        'plant_id',
                        widget!.plantRef?.id,
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
                  List<PlantsProfilesRow> columnPlantsProfilesRowList =
                      snapshot.data!;

                  final columnPlantsProfilesRow =
                      columnPlantsProfilesRowList.isNotEmpty
                          ? columnPlantsProfilesRowList.first
                          : null;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 12.0, 10.0, 20.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'kh5phkc5' /* Manage the plant */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlutterFlowIconButton(
                              borderRadius: 18.0,
                              buttonSize: 60.0,
                              fillColor: FlutterFlowTheme.of(context).primary,
                              icon: Icon(
                                Icons.people_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 38.0,
                              ),
                              onPressed: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: InviteFriendWidget(
                                        plant: widget!.plantRef!,
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                            ),
                            if (columnPlantsProfilesRow?.ownerId ==
                                currentUserUid)
                              FlutterFlowIconButton(
                                borderRadius: 18.0,
                                buttonSize: 60.0,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: Icon(
                                  Icons.edit_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 38.0,
                                ),
                                onPressed: () async {
                                  Navigator.pop(context, false);
                                },
                              ),
                            Stack(
                              children: [
                                if (columnPlantsProfilesRow?.ownerId !=
                                    currentUserUid)
                                  FlutterFlowIconButton(
                                    borderRadius: 18.0,
                                    buttonSize: 60.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).error,
                                    icon: Icon(
                                      Icons.exit_to_app_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 38.0,
                                    ),
                                    onPressed: () async {
                                      await PlantsProfilesTable().delete(
                                        matchingRows: (rows) => rows
                                            .eqOrNull(
                                              'user_id',
                                              currentUserUid,
                                            )
                                            .eqOrNull(
                                              'plant_id',
                                              widget!.plantRef?.id,
                                            ),
                                      );

                                      context
                                          .pushNamed(DashboardWidget.routeName);
                                    },
                                  ),
                                if (columnPlantsProfilesRow?.ownerId ==
                                    currentUserUid)
                                  Opacity(
                                    opacity: 0.8,
                                    child: FlutterFlowIconButton(
                                      borderRadius: 18.0,
                                      buttonSize: 60.0,
                                      fillColor:
                                          FlutterFlowTheme.of(context).error,
                                      icon: Icon(
                                        Icons.delete_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 38.0,
                                      ),
                                      onPressed: () async {
                                        await PlantsTable().delete(
                                          matchingRows: (rows) => rows
                                              .eqOrNull(
                                                'id',
                                                columnPlantsProfilesRow
                                                    ?.plantId,
                                              )
                                              .eqOrNull(
                                                'owner_id',
                                                columnPlantsProfilesRow?.userId,
                                              ),
                                        );
                                        await PlantsProfilesTable().delete(
                                          matchingRows: (rows) => rows
                                              .eqOrNull(
                                                'plant_id',
                                                widget!.plantRef?.id,
                                              )
                                              .eqOrNull(
                                                'owner_id',
                                                currentUserUid,
                                              ),
                                        );

                                        context.pushNamed(
                                            DashboardWidget.routeName);
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ].divide(SizedBox(width: 20.0)),
                        ),
                      ),
                      if (columnPlantsProfilesRow?.plantId == '123')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 32.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 18.0,
                                buttonSize: 60.0,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: Icon(
                                  Icons.water_drop,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 38.0,
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: InviteFriendWidget(
                                          plant: widget!.plantRef!,
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 18.0,
                                buttonSize: 60.0,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: FaIcon(
                                  FontAwesomeIcons.poo,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 38.0,
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: InviteFriendWidget(
                                          plant: widget!.plantRef!,
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 18.0,
                                buttonSize: 60.0,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: Icon(
                                  Icons.local_florist,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 38.0,
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: InviteFriendWidget(
                                          plant: widget!.plantRef!,
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 18.0,
                                buttonSize: 60.0,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: FaIcon(
                                  FontAwesomeIcons.cut,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 38.0,
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: InviteFriendWidget(
                                          plant: widget!.plantRef!,
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
