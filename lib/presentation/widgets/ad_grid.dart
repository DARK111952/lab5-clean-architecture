import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/search_notifier.dart';
import 'ad_card.dart';

/// Сітка оголошень, що фільтрується через context.watch<SearchNotifier>().
class AdGrid extends StatelessWidget {
  const AdGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // watch: сітка перебудовується при зміні пошуку/категорії/ціни.
    final visibleAds = context.watch<SearchNotifier>().filteredAds;

    if (visibleAds.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 56, color: Colors.black38),
            const SizedBox(height: 8),
            Text(
              'Нічого не знайдено',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 600 ? 4 : 2;
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: visibleAds.length,
          itemBuilder: (context, index) {
            final ad = visibleAds[index];
            return AdCard(key: ValueKey(ad.id), ad: ad);
          },
        );
      },
    );
  }
}
