import 'package:flutter/material.dart';
import '../../../core/widgets/widgets.dart';
import '../my_shelf_controller.dart';

/// Filtros de status da estante
class ShelfFilterChips extends StatelessWidget {
  final ShelfFilter selectedFilter;
  final ValueChanged<ShelfFilter> onFilterSelected;

  const ShelfFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Converte ShelfFilter para FilterItem
    final items = ShelfFilter.values
        .map((filter) => FilterItem(value: filter, label: filter.label))
        .toList();

    return FilterChips<ShelfFilter>(
      items: items,
      selectedValue: selectedFilter,
      onFilterSelected: onFilterSelected,
    );
  }
}
