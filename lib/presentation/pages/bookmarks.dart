import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memoire/presentation/layouts/home.dart';
import 'package:memoire/presentation/viewmodel/bookmark_list.dart';
import 'package:memoire/presentation/widgets/add_bookmark_dialog.dart';
import 'package:memoire/presentation/widgets/bookmark_list_item.dart';

@RoutePage()
class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarkListViewModelProvider);

    return HomeLayout(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddBookmarkDialog(context);
        },
        tooltip: 'Add bookmark',
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 8,
          vertical: 0,
        ),
        child: bookmarks.when(
          data: (data) {
            if (data.isEmpty) {
              return const Center(child: Text('No bookmarks found.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(),
              itemCount: data.length,
              itemBuilder:
                  (context, index) => BookmarkListItem(bookmark: data[index]),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, stackTrace) =>
                  Center(child: Text('Error: ${error.toString()}')),
        ),
      ),
    );
  }
}
