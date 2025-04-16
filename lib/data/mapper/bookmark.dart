import 'package:memoire/data/entity/bookmark.dart';
import 'package:memoire/domain/models/bookmark.dart';

class BookmarkMapper {
  static Bookmark transformToModel(BookmarkEntity entity) {
    return Bookmark(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      url: entity.url,
      favicon: entity.favicon,
      imageUrl: entity.imageUrl,
      createdAt:
          entity.createdAt != null
              ? DateTime.fromMillisecondsSinceEpoch(entity.createdAt! * 1000)
              : null,
      updatedAt:
          entity.updatedAt != null
              ? DateTime.fromMillisecondsSinceEpoch(entity.updatedAt! * 1000)
              : null,
    );
  }

  static List<Bookmark> transformToModelList(List<BookmarkEntity> entities) {
    return entities.map((e) => transformToModel(e)).toList();
  }
}
