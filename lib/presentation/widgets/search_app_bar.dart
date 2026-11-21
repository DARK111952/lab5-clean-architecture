import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_notifier.dart';
import '../providers/search_notifier.dart';

/// AppBar з полем пошуку та бейджем «Обране».
///
/// StatefulWidget залишився лише заради TextEditingController —
/// це локальний стан віджета, а не глобальний.
class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 64);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final TextEditingController _controller = TextEditingController();
  late final SearchNotifier _search;

  @override
  void initState() {
    super.initState();
    // context.read у initState дозволений: це одноразовий доступ без підписки.
    _search = context.read<SearchNotifier>();
    _search.addListener(_syncTextWithState);
  }

  /// Якщо фільтри скинуто деінде (чип «Скинути»), очищаємо поле вводу.
  void _syncTextWithState() {
    if (_search.query.isEmpty && _controller.text.trim().isNotEmpty) {
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _search.removeListener(_syncTextWithState);
    _controller.dispose();
    super.dispose();
  }

  void _onClearSearch() {
    _controller.clear();
    context.read<SearchNotifier>().setQuery('');
  }

  void _onShowFavorites() {
    final count = context.read<FavoritesNotifier>().count;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Обране: $count')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Selector: перебудова лише коли змінюється «порожній/непорожній» запит.
    final hasQuery =
        context.select<SearchNotifier, bool>((s) => s.query.isNotEmpty);

    return AppBar(
      title: const Text('Маркетплейс'),
      actions: [
        // Consumer: перебудовується лише кнопка з бейджем, а не весь AppBar.
        Consumer<FavoritesNotifier>(
          builder: (context, favorites, _) => IconButton(
            onPressed: _onShowFavorites,
            icon: Badge.count(
              count: favorites.count,
              isLabelVisible: favorites.count > 0,
              child: const Icon(Icons.favorite_border),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: TextField(
            controller: _controller,
            onChanged: (value) => context.read<SearchNotifier>().setQuery(value),
            decoration: InputDecoration(
              hintText: 'Пошук оголошень',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: hasQuery
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _onClearSearch,
                    )
                  : null,
              filled: true,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
