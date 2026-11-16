
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:style_hub/main.dart';

void main() {
  testWidgets('STYLE HUB menampilkan halaman utama', (WidgetTester tester) async {
    await tester.pumpWidget(const StyleHubApp());

    expect(find.text('STYLE HUB'), findsOneWidget);
    expect(find.text('Discover your own style.'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Popular Products'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
