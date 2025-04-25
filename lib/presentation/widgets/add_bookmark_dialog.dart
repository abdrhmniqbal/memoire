import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memoire/presentation/viewmodel/bookmark_form.dart';
import 'package:memoire/presentation/widgets/forms.dart';
import 'package:memoire/config/i18n/app_localizations.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class AddBookmarkSheetContent extends HookConsumerWidget {
  const AddBookmarkSheetContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final viewModel = ref.read(bookmarkFormViewModelProvider(null).notifier);
    final formState = ref.watch(bookmarkFormViewModelProvider(null));
    final url = formState['url'] ?? '';
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;

    Future<void> handleAddBookmark() async {
      if (isLoading.value) return;
      isLoading.value = true;
      try {
        bool metadata = await viewModel.fetchMetadataFromUrl();
        await viewModel.createBookmark();
        if (context.mounted) Navigator.of(context).pop();
        if (!metadata && context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(t.fetchFailedMessage)));
        }
      } catch (e) {
        if (context.mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(t.addItem(t.bookmark), style: theme.textTheme.titleLarge),
          Text(
            t.addBookmarkDescription,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          StringFormField(
            label: t.inputMessage(t.link.toLowerCase()),
            placeholder: 'https://',
            value: url,
            onChanged: viewModel.setUrl,
            validator:
                (value) =>
                    (value == null || value.isEmpty)
                        ? t.requiredMessage(t.link)
                        : null,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed:
                  isLoading.value || url.isEmpty ? null : handleAddBookmark,
              child:
                  isLoading.value
                      ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : Text(t.add),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed:
                  isLoading.value ? null : () => Navigator.of(context).pop(),
              child: Text(t.cancel),
            ),
          ),
        ],
      ),
    );
  }
}

void showAddBookmarkDialog(BuildContext context) {
  WoltModalSheet.show<void>(
    context: context,
    pageListBuilder: (context) {
      return [
        WoltModalSheetPage(
          hasTopBarLayer: false,
          child: const AddBookmarkSheetContent(),
        ),
      ];
    },
    onModalDismissedWithDrag: Navigator.of(context).pop,
    modalTypeBuilder: (_) => WoltModalType.dialog(),
  );
}
