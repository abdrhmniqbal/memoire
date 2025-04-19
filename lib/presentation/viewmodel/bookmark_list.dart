import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:memoire/domain/models/bookmark.dart';
import 'package:memoire/domain/usecases/create_bookmark.dart';
import 'package:memoire/domain/usecases/delete_bookmark.dart';
import 'package:memoire/domain/usecases/get_bookmark_list.dart';

part 'bookmark_list.g.dart';

@riverpod
class BookmarkListViewModel extends _$BookmarkListViewModel {
  @override
  Future<List<Bookmark>> build() async {
    final bookmarks = ref.watch(getBookmarkListUseCaseProvider).valueOrNull;
    if (bookmarks == null) return [];
    return bookmarks;
  }

  Future<void> addBookmark(
    final String? title,
    final String? description,
    final String url,
    final String? favicon,
    final String? imageUrl,
  ) async {
    return ref.watch(
      createBookmarkUseCaseProvider(
        title,
        description,
        url,
        favicon,
        imageUrl,
      ).future,
    );
  }

  Future<void> deleteBookmark(final int id) async {
    return ref.watch(deleteBookmarkUseCaseProvider(id).future);
  }
}
