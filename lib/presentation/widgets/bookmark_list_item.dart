import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:memoire/presentation/viewmodel/bookmark_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:memoire/domain/models/bookmark.dart';
import 'package:memoire/utils/string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class _BookmarkAction {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  _BookmarkAction({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.trailing,
  });
}

class ActionTile extends StatelessWidget {
  final _BookmarkAction action;
  final BorderRadius? borderRadius;

  const ActionTile({super.key, required this.action, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: action.onTap,
      borderRadius: borderRadius,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(action.icon, size: 20, color: theme.colorScheme.onSurface),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(action.title, style: theme.textTheme.bodyMedium),
                  if (action.subtitle != null)
                    Text(
                      action.subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                ],
              ),
            ),
            if (action.trailing != null) action.trailing!,
          ],
        ),
      ),
    );
  }
}

class BookmarkListItem extends ConsumerWidget {
  const BookmarkListItem({super.key, required this.bookmark});
  final Bookmark bookmark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;
    final viewModel = ref.read(bookmarkListViewModelProvider.notifier);

    void showBookmarkActions(BuildContext context) {
      final navigator = Navigator.of(context);
      final messenger = ScaffoldMessenger.of(context);

      void close(VoidCallback cb) {
        navigator.pop();
        cb();
      }

      final actions = <_BookmarkAction>[
        _BookmarkAction(
          icon: Icons.copy_outlined,
          title: t.copyLink,
          subtitle: bookmark.url,
          onTap:
              () => close(() async {
                await Clipboard.setData(ClipboardData(text: bookmark.url));
                messenger.showSnackBar(
                  SnackBar(content: Text(t.copyLinkSuccess)),
                );
              }),
        ),
        _BookmarkAction(
          icon: Icons.open_in_browser_outlined,
          title: t.openInBrowser,
          onTap:
              () => close(() async {
                final uri = Uri.parse(bookmark.url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  messenger.showSnackBar(
                    SnackBar(content: Text(t.openInBrowserFail)),
                  );
                }
              }),
        ),
        _BookmarkAction(
          icon: Icons.delete_outline,
          title: t.deleteItem(t.bookmark.toLowerCase()),
          onTap:
              () => close(() async {
                await viewModel.deleteBookmark(bookmark.id);
                messenger.showSnackBar(
                  SnackBar(content: Text(t.deleteItemSuccess(t.bookmark))),
                );
              }),
        ),
      ];

      WoltModalSheet.show(
        context: context,
        modalTypeBuilder: (_) => WoltModalType.dialog(),
        pageListBuilder:
            (_) => [
              WoltModalSheetPage(
                hasTopBarLayer: false,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: theme.colorScheme.surface),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(actions.length, (index) {
                      final action = actions[index];
                      final isFirst = index == 0;
                      final isLast = index == actions.length - 1;

                      final borderRadius = BorderRadius.only(
                        topLeft:
                            isFirst
                                ? const Radius.circular(16)
                                : Radius.circular(4),
                        topRight:
                            isFirst
                                ? const Radius.circular(16)
                                : Radius.circular(4),
                        bottomLeft:
                            isLast
                                ? const Radius.circular(16)
                                : Radius.circular(4),
                        bottomRight:
                            isLast
                                ? const Radius.circular(16)
                                : Radius.circular(4),
                      );

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: ActionTile(
                          action: action,
                          borderRadius: borderRadius,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
      );
    }

    return ListTile(
      onTap: () => showBookmarkActions(context),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child:
              bookmark.favicon != null
                  ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: bookmark.favicon!,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => CircularProgressIndicator(
                            strokeWidth: 2,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                      errorWidget:
                          (context, url, error) => Icon(
                            Icons.broken_image_outlined,
                            size: 24,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                    ),
                  )
                  : Icon(
                    Icons.language_outlined,
                    size: 24,
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
        ),
      ),
      title: Text(
        bookmark.title ?? bookmark.url,
        style: theme.textTheme.titleMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${getHost(bookmark.url)} • ${DateFormat('dd/MM/yyyy').format(bookmark.updatedAt!)}',
        maxLines: 1,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.primary,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
