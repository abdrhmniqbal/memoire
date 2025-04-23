import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MenuItem {
  final String value;
  final String label;
  final IconData? icon;
  final PageRouteInfo? route;
  final List<MenuItem>? children;
  final VoidCallback? onPressed;

  const MenuItem({
    required this.value,
    required this.label,
    this.icon,
    this.route,
    this.children,
    this.onPressed,
  });
}

class Menu extends HookWidget {
  final List<MenuItem> items;
  const Menu({super.key, this.items = const []});

  @override
  Widget build(BuildContext context) {
    final double menuWidth = MediaQuery.of(context).size.width / 3;
    return MenuAnchor(
      builder: (
        BuildContext context,
        MenuController controller,
        Widget? child,
      ) {
        return IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            controller.open();
          },
        );
      },
      menuChildren:
          items.map((item) {
            if (item.children != null && item.children!.isNotEmpty) {
              return SubmenuButton(
                leadingIcon: item.icon != null ? Icon(item.icon) : null,
                menuChildren:
                    item.children!.map((subItem) {
                      return MenuItemButton(
                        leadingIcon:
                            subItem.icon != null ? Icon(subItem.icon) : null,
                        child: SizedBox(
                          width: menuWidth,
                          child: Text(subItem.label),
                        ),
                        onPressed: () {
                          if (subItem.onPressed != null) {
                            subItem.onPressed!();
                          } else if (subItem.route != null) {
                            context.router.push(subItem.route!);
                          }
                        },
                      );
                    }).toList(),
                child: SizedBox(width: menuWidth, child: Text(item.label)),
              );
            } else {
              return MenuItemButton(
                leadingIcon: item.icon != null ? Icon(item.icon) : null,
                child: SizedBox(width: menuWidth, child: Text(item.label)),
                onPressed: () {
                  if (item.onPressed != null) {
                    item.onPressed!();
                  } else if (item.route != null) {
                    context.router.push(item.route!);
                  }
                },
              );
            }
          }).toList(),
    );
  }
}

const List<MenuItem> mainMenuItems = [
  MenuItem(
    value: 'settings',
    label: 'Settings',
    icon: Icons.settings_outlined,
    route: NamedRoute('SettingsRoute'),
  ),
];
