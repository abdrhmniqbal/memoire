import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:memoire/domain/models/bookmark.dart';
import 'package:memoire/config/themes/themes.dart';
import 'package:memoire/utils/string.dart';

class BookmarkListItem extends ConsumerWidget {
  const BookmarkListItem({super.key, required this.bookmark});
  final Bookmark bookmark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    void _showBookmarkActions(BuildContext context) {
      WoltModalSheet.show(
        context: context,
        pageListBuilder: (modalSheetContext) {
          return [
            WoltModalSheetPage(
              hasTopBarLayer: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    leading: const Icon(Icons.copy_outlined),
                    title: const Text('Copy Link'),
                    subtitle: Text(bookmark.url),
                    onTap: () async {
                      await Clipboard.setData(
                        ClipboardData(text: bookmark.url),
                      );
                      Navigator.of(modalSheetContext).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Link copied to clipboard.'),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.open_in_browser_outlined),
                    title: const Text('Open Link'),
                    onTap: () async {
                      if (await canLaunchUrl(Uri.parse(bookmark.url))) {
                        await launchUrl(Uri.parse(bookmark.url));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Could not open browser.'),
                          ),
                        );
                      }
                      Navigator.of(modalSheetContext).pop();
                    },
                  ),
                ],
              ),
            ),
          ];
        },
        modalTypeBuilder: (context) => WoltModalType.dialog(),
      );
    }

    return ListTile(
      onTap: () => _showBookmarkActions(context),
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
