import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_frontend/main.dart';

void main() {
  testWidgets('Shows app title and initial status', (WidgetTester tester) async {
    await tester.pumpWidget(const TicTacToeApp());

    expect(find.text('Tic Tac Toe'), findsOneWidget);
    expect(find.text('Turn: X'), findsOneWidget);
    expect(find.bySemanticsLabel('Game status'), findsOneWidget);
  });

  testWidgets('Tapping a cell places mark and switches turn', (WidgetTester tester) async {
    await tester.pumpWidget(const TicTacToeApp());

    // Tap first cell (top-left). It should become X and turn should change to O.
    await tester.tap(find.bySemanticsLabel('Cell 1, empty'));
    await tester.pump();

    expect(find.text('Turn: O'), findsOneWidget);
    expect(find.text('X'), findsOneWidget);

    // Tap second cell; it should become O and turn should change back to X.
    await tester.tap(find.bySemanticsLabel('Cell 2, empty'));
    await tester.pump();

    expect(find.text('Turn: X'), findsOneWidget);
    expect(find.text('O'), findsOneWidget);
  });

  testWidgets('Reset clears the board and restores initial state', (WidgetTester tester) async {
    await tester.pumpWidget(const TicTacToeApp());

    await tester.tap(find.bySemanticsLabel('Cell 1, empty'));
    await tester.pump();
    expect(find.text('X'), findsOneWidget);

    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(find.text('Turn: X'), findsOneWidget);
    expect(find.text('X'), findsNothing);
    expect(find.bySemanticsLabel('Cell 1, empty'), findsOneWidget);
  });

  testWidgets('Detects win and shows New Game', (WidgetTester tester) async {
    await tester.pumpWidget(const TicTacToeApp());

    // X: 1, O: 4, X: 2, O: 5, X: 3 => X wins on top row.
    await tester.tap(find.bySemanticsLabel('Cell 1, empty'));
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Cell 4, empty'));
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Cell 2, empty'));
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Cell 5, empty'));
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Cell 3, empty'));
    await tester.pump();

    expect(find.text('X wins!'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'New Game'), findsOneWidget);
  });
}
