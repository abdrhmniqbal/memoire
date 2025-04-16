import 'package:drift/drift.dart';
import 'package:memoire/domain/models/bookmark.dart';
import 'package:memoire/data/mapper/bookmark.dart';
import 'package:memoire/data/source/database/database.dart' as db;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmarks.g.dart';

@riverpod
class BookmarksRepository extends _$BookmarksRepository {
  late final db.Database database = ref.read(db.databaseProvider);

  @override
  Stream<List<Bookmark>> build() {
    return database.watchBookmarks().map(BookmarkMapper.transformToModelList);
  }

  Future<Bookmark> createBookmark({
    required String? title,
    required String? description,
    required String url,
    required String? favicon,
    required String? imageUrl,
  }) async {
    final model = await database.createBookmark(
      db.BookmarksCompanion.insert(
        // Menggunakan 'db.BookmarksCompanion'
        title: Value(title),
        description: Value(description),
        url: url,
        favicon: Value(favicon),
        imageUrl: Value(imageUrl),
      ),
    );
    return BookmarkMapper.transformToModel(model);
  }
}
