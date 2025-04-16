import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memoire/presentation/viewmodel/bookmark_form.dart';
import 'package:memoire/presentation/widgets/forms.dart';

class AddBookmarkDialog extends HookConsumerWidget {
  const AddBookmarkDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final viewModel = ref.read(bookmarkFormViewModelProvider(null).notifier);
    final formState = ref.watch(bookmarkFormViewModelProvider(null));
    final url = formState['url'] ?? '';

    Future<void> handleAddBookmark() async {
      if (isLoading.value) return;
      isLoading.value = true;
      try {
        bool metadata = await viewModel.fetchMetadataFromUrl();
        await viewModel.createBookmark();
        if (context.mounted) Navigator.of(context).pop();
        if (!metadata && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'There are problem while fetching metadata, use default data instead.',
              ),
            ),
          );
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

    return AlertDialog(
      title: const Text('Add Bookmark'),
      content: StringFormField(
        label: 'Enter bookmark link',
        placeholder: 'https://',
        value: url,
        onChanged: viewModel.setUrl,
        validator:
            (value) =>
                (value == null || value.isEmpty) ? 'URL is required' : null,
      ),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed:
                  isLoading.value || url.isEmpty ? null : handleAddBookmark,
              child:
                  isLoading.value
                      ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Text('Add'),
            ),
            TextButton(
              onPressed:
                  isLoading.value ? null : () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ],
    );
  }
}

void showAddBookmarkDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => const AddBookmarkDialog());
}
