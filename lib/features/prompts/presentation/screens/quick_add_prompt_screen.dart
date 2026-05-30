import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../providers/prompt_providers.dart';

class QuickAddPromptScreen extends ConsumerStatefulWidget {
  const QuickAddPromptScreen({super.key});

  @override
  ConsumerState<QuickAddPromptScreen> createState() =>
      _QuickAddPromptScreenState();
}

class _QuickAddPromptScreenState extends ConsumerState<QuickAddPromptScreen> {
  final _promptTextController = TextEditingController();
  String? _promptTextError;

  @override
  void dispose() {
    _promptTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(quickAddPromptControllerProvider, (
      previous,
      next,
    ) {
      final wasLoading = previous?.isLoading ?? false;
      final isSuccess = wasLoading && next.hasValue && !next.isLoading;

      if (isSuccess) {
        context.go(RoutePaths.library);
      }

      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Prompt kaydedilemedi. Lutfen tekrar deneyin.'),
          ),
        );
      }
    });

    final createState = ref.watch(quickAddPromptControllerProvider);
    final isLoading = createState.isLoading;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Hizli Ekle')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Prompt metni',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _promptTextController,
                    enabled: !isLoading,
                    minLines: 8,
                    maxLines: 16,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: 'Promptunu buraya yaz...',
                      errorText: _promptTextError,
                    ),
                    onChanged: (_) {
                      if (_promptTextError == null) {
                        return;
                      }

                      setState(() {
                        _promptTextError = null;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Sadece metni kaydet. Baslik, etiket ve diger ayrintilar sonraki adimlarda gelecek.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: isLoading ? null : _submit,
                    icon: isLoading
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save_outlined),
                    label: Text(isLoading ? 'Kaydediliyor' : 'Kaydet'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final promptText = _promptTextController.text;
    if (promptText.trim().isEmpty) {
      setState(() {
        _promptTextError = 'Prompt metni bos olamaz.';
      });
      return;
    }

    ref
        .read(quickAddPromptControllerProvider.notifier)
        .createPrompt(promptText: promptText);
  }
}
