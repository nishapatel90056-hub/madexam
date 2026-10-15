
import 'package:flutter_test/flutter_test.dart';
import '../lib/course_management.dart';

void main() {
  testWidgets('Course app displays splash screen', (
      WidgetTester tester,
      ) async {
    await tester.pumpWidget(const CourseManagementApp());

    expect(find.text('COURSE MANAGEMENT'), findsOneWidget);
    expect(find.text('Manage Your Courses Easily'), findsOneWidget);
  });
}
