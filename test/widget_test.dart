import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/main.dart';

void main() {
  test('computeTip calculates 15 percent correctly', () {
    final result = computeTip(500, 15);

    expect(result.tip, 75.0);
    expect(result.total, 575.0);
  });

  test('computeTip calculates 10 percent correctly', () {
    final result = computeTip(500, 10);

    expect(result.tip, 50.0);
    expect(result.total, 550.0);
  });

  test('computeTip calculates 20 percent correctly', () {
    final result = computeTip(500, 20);

    expect(result.tip, 100.0);
    expect(result.total, 600.0);
  });

  test('parseBill handles invalid input', () {
    expect(parseBill('abc'), isNull);
  });

  test('parseBill handles valid input', () {
    expect(parseBill('500'), 500.0);
  });
}