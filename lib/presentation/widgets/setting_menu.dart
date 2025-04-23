import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memoire/presentation/layouts/setting.dart';

abstract class SettingEntry extends StatelessWidget {
  const SettingEntry({super.key});
}

class SettingItem extends SettingEntry {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onTap;
  final List<SettingEntry>? children;

  const SettingItem({
    Key? key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onTap,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class SettingDivider extends SettingEntry {
  const SettingDivider({super.key});

  @override
  Widget build(BuildContext context) {
    // Indented to align with text in SettingMenu
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(thickness: 1, height: 24),
    );
  }
}

/// The widget that drives the single-page nested navigation.
class SettingMenu extends HookWidget {
  final String title;
  final List<SettingEntry> children;

  const SettingMenu({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final menuStack = useState<List<List<SettingEntry>>>([children]);
    final currentList = menuStack.value.last;
    final currentTitle = _computeTitle(menuStack.value) ?? title;

    return SettingLayout(
      title: currentTitle,
      leading:
          menuStack.value.length > 1
              ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  // Pop one level
                  menuStack.value = menuStack.value.sublist(
                    0,
                    menuStack.value.length - 1,
                  );
                },
              )
              : null,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((ctx, idx) {
            final entry = currentList[idx];
            if (entry is SettingDivider) {
              return entry;
            }
            if (entry is SettingItem) {
              return _buildItem(ctx, entry, menuStack);
            }
            return const SizedBox.shrink();
          }, childCount: currentList.length),
        ),
      ],
    );
  }

  String? _computeTitle(List<List<SettingEntry>> stack) {
    if (stack.length <= 1) return null;
    final parent = stack[stack.length - 2];
    for (var e in parent) {
      if (e is SettingItem &&
          e.children != null &&
          identical(e.children, stack.last)) {
        return e.title;
      }
    }
    return null;
  }

  Widget _buildItem(
    BuildContext context,
    SettingItem item,
    ValueNotifier<List<List<SettingEntry>>> menuStack,
  ) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading:
          item.icon != null
              ? Icon(item.icon, color: theme.colorScheme.primary)
              : null,
      title: Text(item.title),
      subtitle:
          item.subtitle != null
              ? Text(
                item.subtitle!,
                style: TextStyle(color: theme.colorScheme.outline),
              )
              : null,
      trailing: item.children != null ? const Icon(Icons.chevron_right) : null,
      onTap: () {
        if (item.children != null && item.children!.isNotEmpty) {
          menuStack.value = [...menuStack.value, item.children!];
        } else {
          item.onTap?.call();
        }
      },
    );
  }
}
