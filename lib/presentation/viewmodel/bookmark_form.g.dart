// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_form.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookmarkFormViewModelHash() =>
    r'bca03c2192b4069cda2a51456c4f1b5472530b8c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$BookmarkFormViewModel
    extends BuildlessAutoDisposeNotifier<FormData> {
  late final Bookmark? bookmark;

  FormData build(Bookmark? bookmark);
}

/// See also [BookmarkFormViewModel].
@ProviderFor(BookmarkFormViewModel)
const bookmarkFormViewModelProvider = BookmarkFormViewModelFamily();

/// See also [BookmarkFormViewModel].
class BookmarkFormViewModelFamily extends Family<FormData> {
  /// See also [BookmarkFormViewModel].
  const BookmarkFormViewModelFamily();

  /// See also [BookmarkFormViewModel].
  BookmarkFormViewModelProvider call(Bookmark? bookmark) {
    return BookmarkFormViewModelProvider(bookmark);
  }

  @override
  BookmarkFormViewModelProvider getProviderOverride(
    covariant BookmarkFormViewModelProvider provider,
  ) {
    return call(provider.bookmark);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'bookmarkFormViewModelProvider';
}

/// See also [BookmarkFormViewModel].
class BookmarkFormViewModelProvider
    extends AutoDisposeNotifierProviderImpl<BookmarkFormViewModel, FormData> {
  /// See also [BookmarkFormViewModel].
  BookmarkFormViewModelProvider(Bookmark? bookmark)
    : this._internal(
        () => BookmarkFormViewModel()..bookmark = bookmark,
        from: bookmarkFormViewModelProvider,
        name: r'bookmarkFormViewModelProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$bookmarkFormViewModelHash,
        dependencies: BookmarkFormViewModelFamily._dependencies,
        allTransitiveDependencies:
            BookmarkFormViewModelFamily._allTransitiveDependencies,
        bookmark: bookmark,
      );

  BookmarkFormViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bookmark,
  }) : super.internal();

  final Bookmark? bookmark;

  @override
  FormData runNotifierBuild(covariant BookmarkFormViewModel notifier) {
    return notifier.build(bookmark);
  }

  @override
  Override overrideWith(BookmarkFormViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: BookmarkFormViewModelProvider._internal(
        () => create()..bookmark = bookmark,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bookmark: bookmark,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<BookmarkFormViewModel, FormData>
  createElement() {
    return _BookmarkFormViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookmarkFormViewModelProvider && other.bookmark == bookmark;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookmark.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BookmarkFormViewModelRef on AutoDisposeNotifierProviderRef<FormData> {
  /// The parameter `bookmark` of this provider.
  Bookmark? get bookmark;
}

class _BookmarkFormViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<BookmarkFormViewModel, FormData>
    with BookmarkFormViewModelRef {
  _BookmarkFormViewModelProviderElement(super.provider);

  @override
  Bookmark? get bookmark => (origin as BookmarkFormViewModelProvider).bookmark;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
