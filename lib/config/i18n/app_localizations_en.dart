// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Memoire';

  @override
  String get add => 'Add';

  @override
  String get cancel => 'Cancel';

  @override
  String get settings => 'Settings';

  @override
  String get bookmark => 'Bookmark';

  @override
  String get appearance => 'Appearance';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get link => 'Link';

  @override
  String addItem(Object item) {
    return 'Add $item';
  }

  @override
  String get addBookmarkDescription => 'Enter a valid link to save as a bookmark.';

  @override
  String deleteItem(Object item) {
    return 'Delete $item';
  }

  @override
  String deleteItemSuccess(Object item) {
    return '$item deleted.';
  }

  @override
  String get copyLink => 'Copy link';

  @override
  String get copyLinkSuccess => 'Link copied to clipboard.';

  @override
  String get openInBrowser => 'Open in browser';

  @override
  String get openInBrowserFail => 'There are problem while opening browser.';

  @override
  String noItemFound(Object item) {
    return 'No $item found.';
  }

  @override
  String inputMessage(Object item) {
    return 'Input $item here';
  }

  @override
  String requiredMessage(Object item) {
    return '$item is required.';
  }

  @override
  String get fetchFailedMessage => 'There are problem while fetching metadata, use default data instead.';
}
