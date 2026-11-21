import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/search_notifier.dart';

/// Лічильник «Знайдено оголошень». Selector підписує віджет лише на
/// кількість результатів, а не на весь SearchNotifier.
class ResultsCounter extends StatelessWidget {
  const ResultsCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Selector<SearchNotifier, int>(
        selector: (_, search) => search.filteredAds.length,
        builder: (context, count, _) => Text(
          'Знайдено оголошень: $count',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
