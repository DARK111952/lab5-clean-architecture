import 'package:flutter/material.dart';

import '../widgets/ad_grid.dart';
import '../widgets/filter_panel.dart';
import '../widgets/results_counter.dart';
import '../widgets/search_app_bar.dart';

/// Головний екран (ЛР №4). Тепер StatelessWidget: глобального стану тут
/// немає, кожен дочірній віджет сам підписується на потрібний Notifier,
/// тож жодні дані не передаються через конструктори (без prop drilling).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SearchAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilterPanel(),
          ResultsCounter(),
          Expanded(child: AdGrid()),
        ],
      ),
    );
  }
}
