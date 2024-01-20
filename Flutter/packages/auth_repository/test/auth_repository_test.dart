import 'package:flutter_test/flutter_test.dart';

class Calculator {
  // Define the Calculator class
  int addOne(int number) {
    return number + 1;
  }
}

void main() {
  test('adds one to input values', () {
    final calculator =
        Calculator(); // Fix the issue by defining the Calculator class
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });
}
