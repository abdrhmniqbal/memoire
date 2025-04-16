import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:memoire/data/repository/bookmarks.dart';
import 'package:memoire/domain/models/bookmark.dart';

part 'create_bookmark.g.dart';

@riverpod
class CreateBookmarkUseCase extends _$CreateBookmarkUseCase {
  @override
  Future<Bookmark> build(
    String? title,
    String? description,
    String url,
    String? favicon,
    String? imageUrl,
  ) {
    final BookmarksRepository repository = ref.read(
      bookmarksRepositoryProvider.notifier,
    );
    return repository.createBookmark(
      title: title,
      description: description,
      url: url,
      favicon: favicon,
      imageUrl: imageUrl,
    );
  }
}
