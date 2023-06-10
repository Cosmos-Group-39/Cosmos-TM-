// import 'package:cosmos_client/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   testWidgets('Test sub workflow creation', (WidgetTester tester) async {
//     // Build the app and trigger a frame.
//     await tester.pumpWidget(MyApp());

//     // Tap on the floating action button to open the create sub workflow screen.
//     await tester.tap(find.byType(FloatingActionButton));
//     await tester.pumpAndSettle();

//     // Fill in the text field with a new sub workflow name.
//     await tester.enterText(find.byType(TextField), 'New Sub Workflow');
//     await tester.pumpAndSettle();

//     // Tap on the "Save" button to create the sub workflow.
//     await tester.tap(find.text('Save'));
//     await tester.pumpAndSettle();

//     // Verify that the sub workflow is created and displayed in the list.
//     expect(find.text('New Sub Workflow'), findsOneWidget);
//   });

//   testWidgets('Test sub workflow deletion', (WidgetTester tester) async {
//     // Build the app and trigger a frame.
//     await tester.pumpWidget(MyApp());

//     // Ensure that a sub workflow named "Test Sub Workflow" exists in the list.
//     expect(find.text('Test Sub Workflow'), findsOneWidget);

//     // Swipe to dismiss the "Test Sub Workflow" tile.
//     await tester.drag(find.text('Test Sub Workflow'), Offset(500, 0));
//     await tester.pumpAndSettle();

//     // Verify that the sub workflow is deleted and no longer displayed in the list.
//     expect(find.text('Test Sub Workflow'), findsNothing);
//   });
// }
