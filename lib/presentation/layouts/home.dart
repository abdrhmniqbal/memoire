import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memoire/config/themes/themes.dart';

class NavigationItem {
  final String label;
  final IconData icon;
  final PageRouteInfo route;

  const NavigationItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}

class HomeLayout extends HookWidget {
  final List<Widget> slivers;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const HomeLayout({
    super.key,
    required this.slivers,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);
    final theme = context.theme;

    final List<NavigationItem> navigationItems = [
      NavigationItem(
        label: 'Bookmarks',
        icon: Icons.bookmarks_outlined,
        route: const NamedRoute("BookmarksView"),
      ),
      NavigationItem(
        label: 'Collections',
        icon: Icons.collections_bookmark_outlined,
        route: const NamedRoute("CollectionsView"),
      ),
      NavigationItem(
        label: 'Search',
        icon: Icons.search_outlined,
        route: const NamedRoute("SearchView"),
      ),
    ];

    return Scaffold(
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex.value,
        onDestinationSelected: (index) {
          currentIndex.value = index;
          context.router.replace(navigationItems[index].route);
        },
        destinations:
            navigationItems
                .map(
                  (item) => NavigationDestination(
                    icon: Icon(item.icon),
                    label: item.label,
                  ),
                )
                .toList(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: true,
            automaticallyImplyLeading: true,
            backgroundColor: theme.colorScheme.surface,
            title: const Text('Memoire'),
            actions: <Widget>[if (actions != null) ...actions!],
          ),
          ...slivers,
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 80,
            ),
          ),
        ],
      ),
    );
  }
}
