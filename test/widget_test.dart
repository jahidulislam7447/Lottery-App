import 'package:flutter_test/flutter_test.dart';
import 'package:lucky_draw/main.dart';

void main() {
  testWidgets('LuckyDraw starts on the entry screen', (tester) async {
    await tester.pumpWidget(const LuckyDrawApp());
    expect(find.byType(EntryPage), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
