import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:memoire/data/repository/bookmarks.dart';

part 'delete_bookmark.g.dart';

@riverpod
class DeleteBookmarkUseCase extends _$DeleteBookmarkUseCase {
  @override
  Future<void> build(final int id) {
    final BookmarksRepository repository = ref.read(
      bookmarksRepositoryProvider.notifier,
    );
    return repository.deleteBookmark(id);
  }
}
