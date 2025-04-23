import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SettingLayout extends HookWidget {
  final String title;
  final Widget? leading;
  final List<Widget> slivers;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const SettingLayout({
    super.key,
    required this.title,
    this.leading,
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
            automaticallyImplyLeading: leading == null,
            leading: leading, // ← pakai leading kalau diset
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
