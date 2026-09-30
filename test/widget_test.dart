import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/main.dart';
import 'package:bmi_calculator/calculator_brain.dart';

void main() {
  group('CalculatorBrain Unit Tests', () {
    test('Calculates Normal BMI correctly', () {
      // 180cm, 70kg -> BMI = 70 / (1.8^2) = 21.6
      final brain = CalculatorBrain(height: 180, weight: 70);
      expect(brain.calculateBMI(), '21.6');
      expect(brain.getResult(), 'Normal');
      expect(brain.getInterpretation(), contains('normal'));
    });

    test('Calculates Overweight BMI correctly', () {
      // 170cm, 85kg -> BMI = 85 / (1.7^2) = 29.4
      final brain = CalculatorBrain(height: 170, weight: 85);
      expect(brain.calculateBMI(), '29.4');
      expect(brain.getResult(), 'Overweight');
      expect(brain.getInterpretation(), contains('higher'));
    });

    test('Calculates Underweight BMI correctly', () {
      // 180cm, 50kg -> BMI = 50 / (1.8^2) = 15.4
      final brain = CalculatorBrain(height: 180, weight: 50);
      expect(brain.calculateBMI(), '15.4');
      expect(brain.getResult(), 'Underweight');
      expect(brain.getInterpretation(), contains('lower'));
    });
  });

  group('BMI Calculator UI & Navigation Tests', () {
    testWidgets('Renders InputPage and navigates to ResultsPage and back',
        (WidgetTester tester) async {
      await tester.pumpWidget(const BMICalculatorApp());

      // Check initial screen elements
      expect(find.text('BMI CALCULATOR'), findsOneWidget);
      expect(find.text('MALE'), findsOneWidget);
      expect(find.text('FEMALE'), findsOneWidget);
      expect(find.text('HEIGHT'), findsOneWidget);
      expect(find.text('WEIGHT'), findsOneWidget);
      expect(find.text('AGE'), findsOneWidget);
      expect(find.text('CALCULATE'), findsOneWidget);

      // Tap female card
      await tester.tap(find.text('FEMALE'));
      await tester.pump();

      // Tap + button on weight
      final addIcons = find.byIcon(Icons.add);
      await tester.tap(addIcons.first);
      await tester.pump();
      expect(find.text('61'), findsOneWidget);

      // Tap - button on age
      final removeIcons = find.byIcon(Icons.remove);
      await tester.tap(removeIcons.last);
      await tester.pump();
      expect(find.text('19'), findsOneWidget);

      // Tap CALCULATE button
      await tester.tap(find.text('CALCULATE'));
      await tester.pumpAndSettle();

      // Verify on ResultsPage
      expect(find.text('Your Result'), findsOneWidget);
      expect(find.text('RE-CALCULATE'), findsOneWidget);

      // Tap RE-CALCULATE button to go back
      await tester.tap(find.text('RE-CALCULATE'));
      await tester.pumpAndSettle();

      // Verify back on InputPage
      expect(find.text('CALCULATE'), findsOneWidget);
    });
  });
}
