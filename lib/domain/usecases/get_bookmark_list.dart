import 'package:memoire/data/repository/bookmarks.dart';
import 'package:memoire/domain/models/bookmark.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_bookmark_list.g.dart';

@riverpod
class GetBookmarkListUseCase extends _$GetBookmarkListUseCase {
  @override
  Future<List<Bookmark>> build() async {
    final repository = ref.watch(bookmarksRepositoryProvider);
    return repository.valueOrNull ?? [];
  }
}
