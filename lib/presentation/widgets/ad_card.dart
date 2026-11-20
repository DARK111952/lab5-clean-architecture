import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/ad.dart';
import '../ad_visuals.dart';
import '../providers/favorites_notifier.dart';
import '../utils/format_price.dart';

/// Картка оголошення. Отримує лише саме оголошення; стан «обране»
/// читає з FavoritesNotifier через Selector, а не через конструктор.
class AdCard extends StatelessWidget {
  const AdCard({super.key, required this.ad});

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final visual = adVisualFor(ad);

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: visual.color,
                alignment: Alignment.center,
                child: Icon(visual.icon, size: 56, color: Colors.black54),
              ),
              Positioned(
                top: 4,
                right: 4,
                // Selector: перебудовується лише серце цієї картки.
                child: Selector<FavoritesNotifier, bool>(
                  selector: (_, favorites) => favorites.isFavorite(ad.id),
                  builder: (context, isFavorite, _) => IconButton(
                    onPressed: () =>
                        context.read<FavoritesNotifier>().toggle(ad.id),
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ad.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          formatPrice(ad.price),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          ad.time,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
