import 'package:shersher/domain/split_engine.dart';
import 'package:test/test.dart';

void main() {
  final all = ['Migs', 'Ana', 'Ben', 'Carla', 'Dan', 'Ella', 'Fe', 'Gio'];
  final items = [
    Item('Pork Belly Set', 128000, all),
    Item('Beef Bulgogi', 62000, ['Ana', 'Ben', 'Carla', 'Dan']),
    Item('Kimchi Fried Rice', 38000, ['Migs', 'Fe']),
    Item('Iced Tea', 36000, ['Carla', 'Dan', 'Ella', 'Gio']),
    Item('Cheese Add-on', 12000, ['Gio']),
  ];

  test('allocate always sums to total', () {
    expect(allocate(128000, List.filled(7, 1)).reduce((a, b) => a + b), 128000);
    expect(allocate(128000, List.filled(7, 1)), [18286, 18286, 18286, 18286, 18286, 18285, 18285]);
    expect(allocate(1, [1, 1, 1]), [1, 0, 0]);
  });

  test('equal split of 3,036 among 8 is 379.50 each', () {
    final r = splitEqually(303600, all);
    expect(r.values.every((v) => v == 37950), isTrue);
  });

  test('per-item split with 10% service matches the prototype', () {
    final r = computeSplit(people: all, items: items, serviceBasisPoints: 1000);
    expect(r.total, 303600);
    expect(r.own['Carla'], 44550);
    expect(r.own['Dan'], 44550);
    expect(r.own['Ella'], 27500);
    expect(r.own['Fe'], 38500);
    expect(r.own['Gio'], 40700);
    expect(r.own['Ana'], 34650);
    expect(r.own['Ben'], 34650);
    expect(r.own['Migs'], 38500);
  });

  test('Migs covering Ana and Ben', () {
    final r = computeSplit(people: all, items: items, serviceBasisPoints: 1000, covers: {'Migs': ['Ana', 'Ben']});
    expect(r.owes['Ana'], 0);
    expect(r.owes['Ben'], 0);
    expect(r.owes['Migs'], 38500 + 34650 * 2);
    expect(r.owes.values.reduce((a, b) => a + b), 303600);
  });

  test('unassigned items are skipped and total still conserved', () {
    final r = computeSplit(people: ['A', 'B'], items: [Item('x', 1000, ['A', 'B']), Item('y', 500, [])]);
    expect(r.total, 1000);
  });

  test('peso formatting', () {
    expect(peso(303600), '₱3,036.00');
    expect(peso(18286), '₱182.86');
    expect(peso(5), '₱0.05');
  });
}
