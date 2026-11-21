import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/search_notifier.dart';
import '../utils/format_price.dart';

/// Чипи категорій, чип ціни та RangeSlider.
///
/// Локальним лишився тільки прапорець показу слайдера (суто UI-стан),
/// усе, що впливає на вибірку, живе в SearchNotifier.
class FilterPanel extends StatefulWidget {
  const FilterPanel({super.key});

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  bool _showPriceSlider = false;

  void _onTogglePriceSlider() {
    setState(() => _showPriceSlider = !_showPriceSlider);
  }

  @override
  Widget build(BuildContext context) {
    // watch: панель перебудовується при зміні категорії, ціни чи запиту.
    final search = context.watch<SearchNotifier>();
    final price = search.price;

    final priceLabel = search.priceFilterActive
        ? '${formatPrice(price.start)} – ${formatPrice(price.end)}'
        : 'Ціна';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final category in search.categories) ...[
                  ChoiceChip(
                    label: Text(category),
                    selected: search.category == category,
                    onSelected: (selected) => context
                        .read<SearchNotifier>()
                        .setCategory(selected ? category : null),
                  ),
                  const SizedBox(width: 8),
                ],
                FilterChip(
                  avatar: const Icon(Icons.tune, size: 18),
                  label: Text(priceLabel),
                  selected: _showPriceSlider || search.priceFilterActive,
                  showCheckmark: false,
                  onSelected: (_) => _onTogglePriceSlider(),
                ),
                if (search.hasActiveFilters) ...[
                  const SizedBox(width: 8),
                  ActionChip(
                    avatar: const Icon(Icons.restart_alt, size: 18),
                    label: const Text('Скинути'),
                    onPressed: () => context.read<SearchNotifier>().reset(),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (_showPriceSlider)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Діапазон ціни: ${formatPrice(price.start)} – '
                  '${formatPrice(price.end)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                RangeSlider(
                  values: price,
                  min: search.minPrice,
                  max: search.maxPrice,
                  divisions: 50,
                  labels: RangeLabels(
                    formatPrice(price.start),
                    formatPrice(price.end),
                  ),
                  onChanged: (values) =>
                      context.read<SearchNotifier>().setPrice(values),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
