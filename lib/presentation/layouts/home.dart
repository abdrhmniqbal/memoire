import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
  final String title;
  final List<Widget> slivers;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const HomeLayout({
    super.key,
    required this.title,
    required this.slivers,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: true,
            automaticallyImplyLeading: true,
            backgroundColor: theme.colorScheme.surface,
            title: Text(title),
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
