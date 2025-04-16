// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  const Bookmark({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.favicon,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String? title;
  final String? description;
  final String url;
  final String? favicon;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    url,
    favicon,
    imageUrl,
    createdAt,
    updatedAt,
  ];

  Bookmark copyWith({
    int? id,
    String? title,
    String? description,
    String? url,
    String? favicon,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Bookmark(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      favicon: favicon ?? this.favicon,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
