// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_bookmark.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deleteBookmarkUseCaseHash() =>
    r'cb9596e293ec094ef1fe6e3e72d364f04c81a2ee';

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

abstract class _$DeleteBookmarkUseCase
    extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final int id;

  FutureOr<void> build(int id);
}

/// See also [DeleteBookmarkUseCase].
@ProviderFor(DeleteBookmarkUseCase)
const deleteBookmarkUseCaseProvider = DeleteBookmarkUseCaseFamily();

/// See also [DeleteBookmarkUseCase].
class DeleteBookmarkUseCaseFamily extends Family<AsyncValue<void>> {
  /// See also [DeleteBookmarkUseCase].
  const DeleteBookmarkUseCaseFamily();

  /// See also [DeleteBookmarkUseCase].
  DeleteBookmarkUseCaseProvider call(int id) {
    return DeleteBookmarkUseCaseProvider(id);
  }

  @override
  DeleteBookmarkUseCaseProvider getProviderOverride(
    covariant DeleteBookmarkUseCaseProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deleteBookmarkUseCaseProvider';
}

/// See also [DeleteBookmarkUseCase].
class DeleteBookmarkUseCaseProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DeleteBookmarkUseCase, void> {
  /// See also [DeleteBookmarkUseCase].
  DeleteBookmarkUseCaseProvider(int id)
    : this._internal(
        () => DeleteBookmarkUseCase()..id = id,
        from: deleteBookmarkUseCaseProvider,
        name: r'deleteBookmarkUseCaseProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$deleteBookmarkUseCaseHash,
        dependencies: DeleteBookmarkUseCaseFamily._dependencies,
        allTransitiveDependencies:
            DeleteBookmarkUseCaseFamily._allTransitiveDependencies,
        id: id,
      );

  DeleteBookmarkUseCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  FutureOr<void> runNotifierBuild(covariant DeleteBookmarkUseCase notifier) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(DeleteBookmarkUseCase Function() create) {
    return ProviderOverride(
      origin: this,
      override: DeleteBookmarkUseCaseProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DeleteBookmarkUseCase, void>
  createElement() {
    return _DeleteBookmarkUseCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteBookmarkUseCaseProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeleteBookmarkUseCaseRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `id` of this provider.
  int get id;
}

class _DeleteBookmarkUseCaseProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DeleteBookmarkUseCase, void>
    with DeleteBookmarkUseCaseRef {
  _DeleteBookmarkUseCaseProviderElement(super.provider);

  @override
  int get id => (origin as DeleteBookmarkUseCaseProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
