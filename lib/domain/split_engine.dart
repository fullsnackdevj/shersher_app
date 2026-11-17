/// SherSher split engine. All money is integer centavos (₱1.00 = 100) so
/// nothing ever drifts: the parts always add back up to the total.
library;

/// Splits [total] centavos across [weights] proportionally using the
/// largest-remainder method. Result always sums to [total].
/// Ties go to the earlier index, so results are deterministic.
List<int> allocate(int total, List<int> weights) {
  if (weights.isEmpty) throw ArgumentError('weights must not be empty');
  if (weights.any((w) => w < 0)) throw ArgumentError('negative weight');
  final sum = weights.fold<int>(0, (a, b) => a + b);
  if (sum == 0) throw ArgumentError('weights sum to zero');
  final base = <int>[];
  final rem = <int>[];
  var given = 0;
  for (final w in weights) {
    base.add(total * w ~/ sum);
    rem.add(total * w % sum);
    given += base.last;
  }
  final order = List<int>.generate(weights.length, (i) => i)
    ..sort((a, b) => rem[b] != rem[a] ? rem[b].compareTo(rem[a]) : a.compareTo(b));
  for (var k = 0; k < total - given; k++) {
    base[order[k]]++;
  }
  return base;
}

class Item {
  final String name;
  final int cents;
  final List<String> sharedBy;
  const Item(this.name, this.cents, this.sharedBy);
}

class SplitResult {
  /// What each person's own consumption costs (incl. service charge).
  final Map<String, int> own;

  /// What each person actually hands over, after "A pays for B and C".
  final Map<String, int> owes;
  final int total;
  const SplitResult(this.own, this.owes, this.total);
}

/// [serviceBasisPoints]: 1000 = 10%. [covers]: payerId -> ids they pay for.
/// An item nobody shares is ignored for splitting but counted in [unassigned].
SplitResult computeSplit({
  required List<String> people,
  required List<Item> items,
  int serviceBasisPoints = 0,
  Map<String, List<String>> covers = const {},
}) {
  final sub = {for (final p in people) p: 0};
  for (final it in items) {
    if (it.sharedBy.isEmpty) continue;
    final parts = allocate(it.cents, List.filled(it.sharedBy.length, 1));
    for (var i = 0; i < parts.length; i++) {
      sub[it.sharedBy[i]] = sub[it.sharedBy[i]]! + parts[i];
    }
  }
  final assigned = sub.values.fold<int>(0, (a, b) => a + b);
  final own = Map<String, int>.from(sub);
  if (serviceBasisPoints > 0 && assigned > 0) {
    final service = (assigned * serviceBasisPoints + 5000) ~/ 10000;
    final ids = people.where((p) => sub[p]! > 0).toList();
    final parts = allocate(service, [for (final p in ids) sub[p]!]);
    for (var i = 0; i < ids.length; i++) {
      own[ids[i]] = own[ids[i]]! + parts[i];
    }
  }
  final owes = Map<String, int>.from(own);
  covers.forEach((payer, covered) {
    for (final c in covered) {
      if (c == payer) continue;
      owes[payer] = owes[payer]! + owes[c]!;
      owes[c] = 0;
    }
  });
  return SplitResult(own, owes, own.values.fold(0, (a, b) => a + b));
}

/// Equal split of everything: [totalCents] among [people].
Map<String, int> splitEqually(int totalCents, List<String> people) {
  final parts = allocate(totalCents, List.filled(people.length, 1));
  return {for (var i = 0; i < people.length; i++) people[i]: parts[i]};
}

String peso(int cents) {
  final neg = cents < 0;
  final c = cents.abs();
  final whole = (c ~/ 100).toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
  return '${neg ? '-' : ''}₱$whole.${(c % 100).toString().padLeft(2, '0')}';
}
