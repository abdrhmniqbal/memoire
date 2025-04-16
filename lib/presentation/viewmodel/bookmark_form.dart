import 'package:memoire/utils/metadata.dart';
import 'package:memoire/utils/string.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:memoire/presentation/viewmodel/bookmark_list.dart';
import 'package:memoire/domain/models/bookmark.dart';

part 'bookmark_form.g.dart';

typedef FormData = Map<String, dynamic>;

@riverpod
class BookmarkFormViewModel extends _$BookmarkFormViewModel {
  late final BookmarkListViewModel bookmarkListViewModel = ref.watch(
    bookmarkListViewModelProvider.notifier,
  );
  bool _edited = false;

  bool get isNew => state['id'] == null;
  bool get isEdited => _edited;

  @override
  FormData build(Bookmark? bookmark) {
    return {
      'id': bookmark?.id,
      'title': bookmark?.title,
      'description': bookmark?.description,
      'url': bookmark?.url,
      'favicon': bookmark?.favicon,
      'imageUrl': bookmark?.imageUrl,
    };
  }

  Future<bool> fetchMetadataFromUrl() async {
    final url = validateUrl(state['url']);
    if (url.isEmpty) return false;
    final metadata = await MetadataFetcher.fetchMetadata(url);

    if (metadata.error != null) return false;

    state = {
      ...state,
      'title': metadata.title,
      'description': metadata.description,
      'favicon': metadata.favicon,
      'imageUrl': metadata.image,
    };

    return true;
  }

  Future<void> createBookmark() {
    final title = state['title'];
    final description = state['description'];
    final url = validateUrl(state['url']);
    final favicon = state['favicon'];
    final imageUrl = state['imageUrl'];

    return bookmarkListViewModel.addBookmark(
      title,
      description,
      url,
      favicon,
      imageUrl,
    );
  }

  void setUrl(String value) {
    state = {...state, 'url': value};
    _edited = true;
  }

  void setTitle(String? value) {
    state = {...state, 'title': value};
    _edited = true;
  }

  void setDescription(String? value) {
    state = {...state, 'description': value};
    _edited = true;
  }

  void setFavicon(String? value) {
    state = {...state, 'favicon': value};
    _edited = true;
  }

  void setImage(String? value) {
    state = {...state, 'imageUrl': value};
    _edited = true;
  }
}

extension FormDataUtils on FormData {
  int? get id => this['id'];
  String? get title => this['title'];
  String? get description => this['description'];
  String get url => this['url'];
  String? get favicon => this['favicon'];
  String? get imageUrl => this['imageUrl'];
}
