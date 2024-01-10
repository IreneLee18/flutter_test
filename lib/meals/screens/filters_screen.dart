import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/meals/providers/filter_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {

  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(filterProvider);
    final onChange = ref.read(filterProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(children: [
        FilterItem(
          title: 'Gluten-free',
          subtitle: 'Only include gluten free meal.',
          value: filters[Filter.glutenFree]!,
          onChange: (status) {
            onChange.toggleStatus(Filter.glutenFree, status);
          },
        ),
        FilterItem(
          title: 'Lactose-free',
          subtitle: 'Only include lactose free meal.',
          value: filters[Filter.lactoseFree]!,
          onChange: (status) {
            onChange.toggleStatus(Filter.lactoseFree, status);
          },
        ),
        FilterItem(
          title: 'Vegetarian',
          subtitle: 'Only include vegetarian meal.',
          value: filters[Filter.vegetarian]!,
          onChange: (status) {
            onChange.toggleStatus(Filter.vegetarian, status);
          },
        ),
        FilterItem(
          title: 'Vegan',
          subtitle: 'Only include vegan meal.',
          value: filters[Filter.vegan]!,
          onChange: (status) {
            onChange.toggleStatus(Filter.vegan, status);
          },
        ),
      ]),
    );
  }
}

class FilterItem extends StatelessWidget {
  const FilterItem({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChange,
    super.key,
  });
  final String title;
  final String subtitle;
  final bool value;
  final Function(bool status) onChange;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChange,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
