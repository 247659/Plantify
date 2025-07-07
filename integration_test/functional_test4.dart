import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    FlutterExceptionHandler? originalOnError;



  setUpAll(() async {
    await initFirebase();
    await SupaFlow.initialize();

    await FlutterFlowTheme.initialize();

    await FFLocalizations.initialize();
        originalOnError = FlutterError.onError;

  });

  setUp(() async {
    await authManager.signOut();
    FFAppState.reset();
    final appState = FFAppState();
    await appState.initializePersistedState();
     originalOnError = FlutterError.onError;
  });

  tearDownAll(() {
    FlutterError.onError = originalOnError;
  });

  tearDown(() {
  FlutterError.onError = originalOnError;
});

  testWidgets('AddMemberPlantTest', (WidgetTester tester) async {

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
    await tester.tap(find.byKey(const ValueKey('RichText_039l')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('emailAddress_oat4')), 'test123@wp.pl');
    await tester.enterText(find.byKey(const ValueKey('password_09tl')), 'test123123');
    await tester.tap(find.byKey(const ValueKey('Button_6g1b'))); //zalogowanie
    await tester.pump(const Duration(seconds: 5)); 
    await tester.pump(const Duration(seconds: 5)); 
    await tester.tap(find.text('kwiatek'));
    await tester.pumpAndSettle(); 
    final target = find.byWidgetPredicate(
      (widget) =>
      widget is IconButton &&
      widget.icon is FaIcon &&
      (widget.icon as FaIcon).icon == FontAwesomeIcons.ellipsisH,
      );

    await tester.tap(target);
    await tester.pumpAndSettle(); 
     final iconButtons = find.byType(IconButton).evaluate().map((e) => e.widget).whereType<IconButton>().toList();

 for (var button in iconButtons) {
   final icon = button.icon;
   print('IconButton zawiera: ${icon}');
   }
    expect(find.text('Manage the plant'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.people_rounded));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'test321');
    await tester.tap(find.text('Invite'));
    await tester.pumpAndSettle();
    expect(find.text('Manage the plant'), findsOneWidget);
  });




testWidgets('AddMember2PlantTest', (WidgetTester tester) async {
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
    await tester.tap(find.byKey(const ValueKey('RichText_039l')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('emailAddress_oat4')), 'test123@wp.pl');
    await tester.enterText(find.byKey(const ValueKey('password_09tl')), 'test123123');
    await tester.tap(find.byKey(const ValueKey('Button_6g1b'))); //zalogowanie
    await tester.pump(const Duration(seconds: 5)); 
    await tester.pump(const Duration(seconds: 5)); 
    await tester.tap(find.text('kwiatek'));
    await tester.pumpAndSettle(); 
    final target = find.byWidgetPredicate(
      (widget) =>
      widget is IconButton &&
      widget.icon is FaIcon &&
      (widget.icon as FaIcon).icon == FontAwesomeIcons.ellipsisH,
      );

    await tester.tap(target);
    await tester.pumpAndSettle(); 
    expect(find.text('Manage the plant'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.people_rounded));
    await tester.pumpAndSettle();
    
    expect(find.text('test321'), findsOneWidget);
//     final iconButtons = find.byType(IconButton).evaluate().map((e) => e.widget).whereType<IconButton>().toList();

//  for (var button in iconButtons) {
//    final icon = button.icon;
//    print('IconButton zawiera: ${icon}');
//    }
//     final target2 = find.byWidgetPredicate(
//       (widget) =>
//       widget is IconButton &&
//       widget.icon is FaIcon &&
//       (widget.icon as FaIcon).icon == FontAwesomeIcons.times,
//       );
//     await tester.tap(target2);
//     await tester.pumpAndSettle();
//     expect(find.text('test321'), findsNothing);

  });


testWidgets('LeavePlantTest', (WidgetTester tester) async {
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
    await tester.tap(find.byKey(const ValueKey('RichText_039l')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('emailAddress_oat4')), 'test321@wp.pl');
    await tester.enterText(find.byKey(const ValueKey('password_09tl')), 'test321321');
    await tester.tap(find.byKey(const ValueKey('Button_6g1b'))); //zalogowanie
    await tester.pump(const Duration(seconds: 5)); 
    await tester.pump(const Duration(seconds: 5)); 
    await tester.tap(find.text('kwiatek'));
    await tester.pumpAndSettle(); 
    final target = find.byWidgetPredicate(
      (widget) =>
      widget is IconButton &&
      widget.icon is FaIcon &&
      (widget.icon as FaIcon).icon == FontAwesomeIcons.ellipsisH,
      );

    await tester.tap(target);
    await tester.pumpAndSettle(); 
    expect(find.text('Manage the plant'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.exit_to_app_rounded));
    await tester.pump(const Duration(seconds: 3)); 
    await tester.pump(const Duration(seconds: 3)); 
    expect(find.text('kwiatek'), findsNothing);
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
