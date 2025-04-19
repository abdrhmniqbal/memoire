import 'package:drift/drift.dart';
import 'package:memoire/data/source/database/connection/connection.dart'
    as impl;
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'database.g.dart';

typedef Val<T> = Value<T>;

final databaseProvider = Provider<Database>(
  (ref) =>
      Database(dbName: 'archive.db', inMemory: false, logStatements: false),
);

@DriftDatabase(include: {'sql/schema.drift'})
class Database extends _$Database {
  Database({
    required this.dbName,
    required this.inMemory,
    required this.logStatements,
  }) : super(
         impl.connect(dbName, inMemory: inMemory, logStatements: logStatements),
       );

  final String dbName;
  final bool inMemory;
  final bool logStatements;

  @override
  int get schemaVersion => 1;

  Future<List<Bookmark>> getAllBookmarks() => _getAllBookmarks().get();

  Stream<List<Bookmark>> watchBookmarks() => _getAllBookmarks().watch();

  Future<Bookmark> createBookmark(BookmarksCompanion bookmark) async {
    final id = await _createBookmark(
      bookmark.title.value,
      bookmark.description.value,
      bookmark.url.value,
      bookmark.favicon.value,
      bookmark.imageUrl.value,
    );
    return _getBookmarkById(id).getSingle();
  }

  Future<Bookmark?> getBookmarkById(int id) =>
      _getBookmarkById(id).getSingleOrNull();
  
  Future<void> deleteBookmark(int id) => _deleteBookmark(id);
}
