// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_bookmark.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createBookmarkUseCaseHash() =>
    r'120ff517e6111dcbd774ec36529a7789b4d28358';

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

abstract class _$CreateBookmarkUseCase
    extends BuildlessAutoDisposeAsyncNotifier<Bookmark> {
  late final String? title;
  late final String? description;
  late final String url;
  late final String? favicon;
  late final String? imageUrl;

  FutureOr<Bookmark> build(
    String? title,
    String? description,
    String url,
    String? favicon,
    String? imageUrl,
  );
}

/// See also [CreateBookmarkUseCase].
@ProviderFor(CreateBookmarkUseCase)
const createBookmarkUseCaseProvider = CreateBookmarkUseCaseFamily();

/// See also [CreateBookmarkUseCase].
class CreateBookmarkUseCaseFamily extends Family<AsyncValue<Bookmark>> {
  /// See also [CreateBookmarkUseCase].
  const CreateBookmarkUseCaseFamily();

  /// See also [CreateBookmarkUseCase].
  CreateBookmarkUseCaseProvider call(
    String? title,
    String? description,
    String url,
    String? favicon,
    String? imageUrl,
  ) {
    return CreateBookmarkUseCaseProvider(
      title,
      description,
      url,
      favicon,
      imageUrl,
    );
  }

  @override
  CreateBookmarkUseCaseProvider getProviderOverride(
    covariant CreateBookmarkUseCaseProvider provider,
  ) {
    return call(
      provider.title,
      provider.description,
      provider.url,
      provider.favicon,
      provider.imageUrl,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createBookmarkUseCaseProvider';
}

/// See also [CreateBookmarkUseCase].
class CreateBookmarkUseCaseProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<CreateBookmarkUseCase, Bookmark> {
  /// See also [CreateBookmarkUseCase].
  CreateBookmarkUseCaseProvider(
    String? title,
    String? description,
    String url,
    String? favicon,
    String? imageUrl,
  ) : this._internal(
        () =>
            CreateBookmarkUseCase()
              ..title = title
              ..description = description
              ..url = url
              ..favicon = favicon
              ..imageUrl = imageUrl,
        from: createBookmarkUseCaseProvider,
        name: r'createBookmarkUseCaseProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$createBookmarkUseCaseHash,
        dependencies: CreateBookmarkUseCaseFamily._dependencies,
        allTransitiveDependencies:
            CreateBookmarkUseCaseFamily._allTransitiveDependencies,
        title: title,
        description: description,
        url: url,
        favicon: favicon,
        imageUrl: imageUrl,
      );

  CreateBookmarkUseCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.title,
    required this.description,
    required this.url,
    required this.favicon,
    required this.imageUrl,
  }) : super.internal();

  final String? title;
  final String? description;
  final String url;
  final String? favicon;
  final String? imageUrl;

  @override
  FutureOr<Bookmark> runNotifierBuild(
    covariant CreateBookmarkUseCase notifier,
  ) {
    return notifier.build(title, description, url, favicon, imageUrl);
  }

  @override
  Override overrideWith(CreateBookmarkUseCase Function() create) {
    return ProviderOverride(
      origin: this,
      override: CreateBookmarkUseCaseProvider._internal(
        () =>
            create()
              ..title = title
              ..description = description
              ..url = url
              ..favicon = favicon
              ..imageUrl = imageUrl,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        title: title,
        description: description,
        url: url,
        favicon: favicon,
        imageUrl: imageUrl,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CreateBookmarkUseCase, Bookmark>
  createElement() {
    return _CreateBookmarkUseCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateBookmarkUseCaseProvider &&
        other.title == title &&
        other.description == description &&
        other.url == url &&
        other.favicon == favicon &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, title.hashCode);
    hash = _SystemHash.combine(hash, description.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);
    hash = _SystemHash.combine(hash, favicon.hashCode);
    hash = _SystemHash.combine(hash, imageUrl.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateBookmarkUseCaseRef
    on AutoDisposeAsyncNotifierProviderRef<Bookmark> {
  /// The parameter `title` of this provider.
  String? get title;

  /// The parameter `description` of this provider.
  String? get description;

  /// The parameter `url` of this provider.
  String get url;

  /// The parameter `favicon` of this provider.
  String? get favicon;

  /// The parameter `imageUrl` of this provider.
  String? get imageUrl;
}

class _CreateBookmarkUseCaseProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<CreateBookmarkUseCase, Bookmark>
    with CreateBookmarkUseCaseRef {
  _CreateBookmarkUseCaseProviderElement(super.provider);

  @override
  String? get title => (origin as CreateBookmarkUseCaseProvider).title;
  @override
  String? get description =>
      (origin as CreateBookmarkUseCaseProvider).description;
  @override
  String get url => (origin as CreateBookmarkUseCaseProvider).url;
  @override
  String? get favicon => (origin as CreateBookmarkUseCaseProvider).favicon;
  @override
  String? get imageUrl => (origin as CreateBookmarkUseCaseProvider).imageUrl;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
