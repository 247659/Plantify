import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:integration_test/integration_test.dart';
import 'package:frontend/flutter_flow/flutter_flow_drop_down.dart';
import 'package:frontend/flutter_flow/flutter_flow_icon_button.dart';
import 'package:frontend/flutter_flow/flutter_flow_widgets.dart';
import 'package:frontend/flutter_flow/flutter_flow_theme.dart';
import 'package:frontend/index.dart';
import 'package:frontend/main.dart';
import 'package:frontend/flutter_flow/flutter_flow_util.dart';

import 'package:provider/provider.dart';
import 'package:frontend/backend/firebase/firebase_config.dart';

import 'package:frontend/backend/supabase/supabase.dart';
import 'package:frontend/auth/supabase_auth/auth_util.dart';

import 'package:frontend/backend/supabase/supabase.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  

  setUpAll(() async {
    await initFirebase();
    await SupaFlow.initialize();

    await FlutterFlowTheme.initialize();

    await FFLocalizations.initialize();
  });

  setUp(() async {
    await authManager.signOut();
    FFAppState.reset();
    final appState = FFAppState();
    await appState.initializePersistedState();
  });

  testWidgets('LogOutTest', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => FFAppState(),
      child: MyApp(),
    ));
    await GoogleFonts.pendingFonts();

    await tester.pumpAndSettle(
      const Duration(milliseconds: 4000),
      EnginePhase.sendSemanticsUpdate,
      const Duration(milliseconds: 5000),
    );
    print('All widgets: ${find.byType(ElevatedButton).evaluate()}');
    expect(find.byKey(const ValueKey('Button_cuvu')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('RichText_039l')));
    await tester.pumpAndSettle(
      const Duration(milliseconds: 4000),
      EnginePhase.sendSemanticsUpdate,
      const Duration(milliseconds: 5000),
    );
    expect(find.byKey(const ValueKey('Button_6g1b')), findsOneWidget);
    await tester.enterText(
        find.byKey(const ValueKey('emailAddress_oat4')), 'test123@wp.pl');
    await tester.enterText(
        find.byKey(const ValueKey('password_09tl')), 'test123123');
    await tester.tap(find.byKey(const ValueKey('Button_6g1b')));
    await tester.pump(const Duration(seconds: 10)); 
    await tester.pump(const Duration(seconds: 10)); 
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle(const Duration(seconds: 10)); 
    expect(find.text('Log out'), findsOneWidget);
    await tester.tap(find.text('Log out'));
    await tester.pump(const Duration(seconds: 10)); 
    await tester.pump(const Duration(seconds: 10)); 
    expect(find.byKey(const ValueKey('Button_cuvu')), findsOneWidget);
  });
}


void _overrideOnError() {
  final originalOnError = FlutterError.onError!;
  FlutterError.onError = (errorDetails) {
    if (_shouldIgnoreError(errorDetails.toString())) {
      return;
    }
    originalOnError(errorDetails);
  };
}

bool _shouldIgnoreError(String error) {
  if (error.contains('ImageCodecException')) {
    return true;
  }

  if (error.contains('overflowed by')) {
    return true;
  }
  if (error.contains('No host specified in URI') ||
      error.contains('EXCEPTION CAUGHT BY IMAGE RESOURCE SERVICE')) {
    return true;
  }
  if (error.contains('setState() called after dispose()')) {
    return true;
  }

  return false;
}
