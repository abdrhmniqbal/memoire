import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:memoire/presentation/layouts/home.dart';

@RoutePage()
class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeLayout(
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 8,
          vertical: 0,
        ),
        child: Center(child: Text('No bookmarks found.')),
          ),
    );
  }
}