import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memoire/presentation/layouts/home.dart';
import 'package:memoire/presentation/viewmodel/bookmark_list.dart';
import 'package:memoire/presentation/widgets/add_bookmark_dialog.dart';
import 'package:memoire/presentation/widgets/bookmark_list_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
@RoutePage()
class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarkListViewModelProvider);
    final t = AppLocalizations.of(context)!;

    return HomeLayout(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddBookmarkDialog(context);
        },
        tooltip: t.addItem(t.bookmark.toLowerCase()),
        child: const Icon(Icons.add),
      ),
      slivers: [
        bookmarks.when(
          data: (data) {
            if (data.isEmpty) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(t.noItemFound(t.bookmark.toLowerCase())),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: BookmarkListItem(bookmark: data[index]),
                );
              }, childCount: data.length),
            );
          },
          loading:
              () => const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              ),
          error:
              (error, _) => SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text('Error: ${error.toString()}')),
              ),
        ),
      ],
    );
  }
}
