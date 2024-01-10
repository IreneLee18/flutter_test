import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    required this.onSelectedScreen,
    super.key,
  });

  final void Function(String screen) onSelectedScreen;

  @override
  Widget build(BuildContext context) {
    return (Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.fastfood,
                  size: 40,
                  color: Colors.white54,
                ),
                const SizedBox(width: 16),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          DrawerItem(
            icon: Icons.restaurant,
            label: 'Meals',
            onTap: onSelectedScreen,
          ),
          DrawerItem(
            icon: Icons.settings,
            label: 'Filters',
            onTap: onSelectedScreen,
          )
        ],
      ),
    ));
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    required this.label,
    required this.icon,
    required this.onTap,
    super.key,
  });
  final String label;
  final IconData icon;
  final void Function(String screen) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      onTap: () {
        onTap(label);
      },
    );
  }
}
