import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:login_screen/app.dart';

void main() {
  setUp(() => GoogleFonts.config.allowRuntimeFetching = false);

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const App());
  }

  Future<void> swipe(WidgetTester tester) async {
    await tester.drag(
      find.byKey(const ValueKey('swipe-knob')),
      const Offset(400, 0),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Swiping with empty fields shows validation errors', (
    tester,
  ) async {
    await pumpApp(tester);

    expect(find.text('Swipe to Log In'), findsOneWidget);
    await swipe(tester);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('Valid swipe logs in', (tester) async {
    await pumpApp(tester);

    await tester.enterText(find.byType(TextFormField).at(0), 'me@wallet.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'secret123');
    await swipe(tester);
    expect(find.text('Logged in as me@wallet.com'), findsOneWidget);

    // Let the knob reset and the snackbar close.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('Swipe to Log In'), findsOneWidget);
  });

  testWidgets('Sign Up tab adds a name field', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Swipe to Sign Up'), findsOneWidget);
  });
}
