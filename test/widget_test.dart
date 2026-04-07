import 'package:flutter_test/flutter_test.dart';

double add(double a, double b) => a + b;
double subtract(double a, double b) => a - b;
double multiply(double a, double b) => a * b;
double divide(double a, double b) {
  if (b == 0) throw ArgumentError('Division by zero');
  return a / b;
}

int factorial(int n) {
  if (n < 0) throw ArgumentError('Negative input');
  if (n == 0) return 1;
  return n * factorial(n - 1);
}

bool isPrime(int n) {
  if (n < 2) return false;
  for (int i = 2; i * i <= n; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

void main() {
  group('Basic arithmetic', () {
    test('add: 3 + 4 = 7', () {
      expect(add(3, 4), equals(7));
    });

    test('add: negative numbers', () {
      expect(add(-5, 3), equals(-2));
    });

    test('subtract: 10 - 6 = 4', () {
      expect(subtract(10, 6), equals(4));
    });

    test('multiply: 7 × 8 = 56', () {
      expect(multiply(7, 8), equals(56));
    });

    test('divide: 15 / 3 = 5', () {
      expect(divide(15, 3), equals(5));
    });

    test('divide: throws on division by zero', () {
      expect(() => divide(10, 0), throwsArgumentError);
    });
  });

  group('Factorial', () {
    test('0! = 1', () => expect(factorial(0), equals(1)));
    test('1! = 1', () => expect(factorial(1), equals(1)));
    test('5! = 120', () => expect(factorial(5), equals(120)));
    test('10! = 3628800', () => expect(factorial(10), equals(3628800)));
    test('negative throws', () {
      expect(() => factorial(-1), throwsArgumentError);
    });
  });

  group('Prime numbers', () {
    test('2 is prime', () => expect(isPrime(2), isTrue));
    test('17 is prime', () => expect(isPrime(17), isTrue));
    test('1 is not prime', () => expect(isPrime(1), isFalse));
    test('9 is not prime', () => expect(isPrime(9), isFalse));
    test('100 is not prime', () => expect(isPrime(100), isFalse));
  });
}
