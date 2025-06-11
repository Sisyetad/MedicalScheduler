import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';

// Make sure to replace 'your_app_name' with your actual package name if needed
import 'package:medical_scheduler/presentation/widgets/profile_widget.dart';

void main() {
  // A sample User object to be used in tests.
  // This makes tests predictable and independent of any real data.
  final sampleUser = User(
    userId: 1,
    username: 'John Doe',
    email: 'john.doe@example.com',
    role: Role(roleId: 1, name: 'Patient'),
    createdAt: '2023-01-01',
    updatedAt: '2023-01-01',
  );

  // Helper function to pump the widget within a MaterialApp scope.
  // This provides the widget with a proper context (e.g., text direction).
  Future<void> pumpProfileWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileWidget(user: sampleUser),
        ),
      ),
    );
  }

  group('ProfileWidget Tests', () {
    testWidgets('renders correctly and displays user information', (WidgetTester tester) async {
      await pumpProfileWidget(tester);

      expect(find.text(sampleUser.username), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      final image = tester.widget<Image>(find.byType(Image));
      expect((image.image as AssetImage).assetName, 'assets/images/profile.png');
    });

    // THIS IS THE CORRECTED TEST
    testWidgets('has the correct container styling and shadow', (WidgetTester tester) async {
      await pumpProfileWidget(tester);

      // We use a more specific finder to avoid ambiguity with the CircleAvatar's internal Container.
      // This predicate finds a Container widget that specifically has a width constraint of 250.
      final containerFinder = find.byWidgetPredicate(
        (widget) => widget is Container && widget.constraints?.maxWidth == 250,
      );

      // Verify that our specific container was found.
      expect(containerFinder, findsOneWidget);

      // Now we can safely inspect its properties.
      final container = tester.widget<Container>(containerFinder);
      final boxDecoration = container.decoration as BoxDecoration;

      expect(boxDecoration.color, const Color(0xFFE5F9FF));
      expect(boxDecoration.borderRadius, BorderRadius.circular(12));
      expect(boxDecoration.boxShadow, isNotNull);
      expect(boxDecoration.boxShadow!.length, 1);
      expect(boxDecoration.boxShadow!.first.color, Colors.grey.withOpacity(0.3));
      expect(boxDecoration.boxShadow!.first.blurRadius, 4);
      expect(boxDecoration.boxShadow!.first.offset, const Offset(0, 3));
    });

    testWidgets('displays CircleAvatar with correct properties', (WidgetTester tester) async {
      await pumpProfileWidget(tester);

      final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));

      expect(avatar.radius, 40);
      expect(avatar.backgroundColor, Colors.white);
    });

    testWidgets('displays username with correct text style', (WidgetTester tester) async {
      await pumpProfileWidget(tester);

      final textWidget = tester.widget<Text>(find.text(sampleUser.username));

      expect(textWidget.style?.fontSize, 18);
      expect(textWidget.style?.fontWeight, FontWeight.w500);
      expect(textWidget.style?.color, Colors.black87);
      expect(textWidget.textAlign, TextAlign.center);
    });
  });
}