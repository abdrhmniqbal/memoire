// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookmarksRepositoryHash() =>
    r'ba2511cb39d60fdb3d00a7f42c0736402d8a8b10';

/// See also [BookmarksRepository].
@ProviderFor(BookmarksRepository)
final bookmarksRepositoryProvider = AutoDisposeStreamNotifierProvider<
  BookmarksRepository,
  List<Bookmark>
>.internal(
  BookmarksRepository.new,
  name: r'bookmarksRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bookmarksRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BookmarksRepository = AutoDisposeStreamNotifier<List<Bookmark>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
