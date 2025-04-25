import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:memoire/config/i18n/app_localizations.dart';
import 'package:memoire/presentation/widgets/setting_menu.dart';
import 'package:package_info_plus/package_info_plus.dart';

@RoutePage()
class SettingsPage extends HookWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final packageInfoFuture = useMemoized(() => PackageInfo.fromPlatform());
    final packageInfo = useFuture(packageInfoFuture);
    final version = packageInfo.data?.version;
    final buildNumber = packageInfo.data?.buildNumber;

    return SettingMenu(
      title: t.settings,
      children: [
        SettingItem(
          title: t.about,
          subtitle:
              version != null ? '${t.appTitle} v$version+$buildNumber' : null,
          icon: Icons.info_outline,
        ),
      ],
    );
  }
}
