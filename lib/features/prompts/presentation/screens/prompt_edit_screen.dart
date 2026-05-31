import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../domain/entities/prompt_card.dart';
import '../../domain/enums/prompt_status.dart';
import '../providers/prompt_providers.dart';

class PromptEditScreen extends ConsumerStatefulWidget {
  const PromptEditScreen({required this.promptId, super.key});

  final String promptId;

  @override
  ConsumerState<PromptEditScreen> createState() => _PromptEditScreenState();
}

class _PromptEditScreenState extends ConsumerState<PromptEditScreen> {
  final _titleController = TextEditingController();
  final _promptTextController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _notesController = TextEditingController();
  final _categoryController = TextEditingController();
  final _tagsController = TextEditingController();

  String? _loadedPromptId;
  String? _promptTextError;
  PromptStatus _status = PromptStatus.raw;

  @override
  void dispose() {
    _titleController.dispose();
    _promptTextController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    _categoryController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(promptEditControllerProvider, (
      previous,
      next,
    ) {
      final wasLoading = previous?.isLoading ?? false;
      final isSuccess = wasLoading && next.hasValue && !next.isLoading;

      if (isSuccess) {
        ref.invalidate(promptDetailProvider(widget.promptId));
        ref.invalidate(currentUserPromptsProvider);
        context.go(RoutePaths.promptDetailLocation(widget.promptId));
      }

      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Prompt guncellenemedi. Lutfen tekrar deneyin.'),
          ),
        );
      }
    });

    final promptState = ref.watch(promptDetailProvider(widget.promptId));

    return Scaffold(
      appBar: AppBar(title: const Text('Prompt Duzenle')),
      body: SafeArea(
        child: promptState.when(
          data: (prompt) {
            if (prompt == null) {
              return const _PromptEditNotFoundState();
            }

            _loadPromptIfNeeded(prompt);
            return _PromptEditForm(
              prompt: prompt,
              titleController: _titleController,
              promptTextController: _promptTextController,
              descriptionController: _descriptionController,
              notesController: _notesController,
              categoryController: _categoryController,
              tagsController: _tagsController,
              promptTextError: _promptTextError,
              status: _status,
              onStatusChanged: (status) {
                setState(() {
                  _status = status;
                });
              },
              onPromptTextChanged: () {
                if (_promptTextError == null) {
                  return;
                }

                setState(() {
                  _promptTextError = null;
                });
              },
              onSubmit: _submit,
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => const _PromptEditErrorState(),
        ),
      ),
    );
  }

  void _loadPromptIfNeeded(PromptCard prompt) {
    if (_loadedPromptId == prompt.id) {
      return;
    }

    _loadedPromptId = prompt.id;
    _titleController.text = prompt.title ?? '';
    _promptTextController.text = prompt.promptText;
    _descriptionController.text = prompt.description ?? '';
    _notesController.text = prompt.notes ?? '';
    _categoryController.text = prompt.category ?? '';
    _tagsController.text = prompt.tags.join(', ');
    _status = prompt.status;
  }

  void _submit(PromptCard prompt) {
    if (_promptTextController.text.trim().isEmpty) {
      setState(() {
        _promptTextError = 'Prompt metni bos olamaz.';
      });
      return;
    }

    ref
        .read(promptEditControllerProvider.notifier)
        .updatePrompt(
          originalPrompt: prompt,
          title: _titleController.text,
          promptText: _promptTextController.text,
          description: _descriptionController.text,
          notes: _notesController.text,
          category: _categoryController.text,
          tagsInput: _tagsController.text,
          status: _status,
        );
  }
}

class _PromptEditForm extends ConsumerWidget {
  const _PromptEditForm({
    required this.prompt,
    required this.titleController,
    required this.promptTextController,
    required this.descriptionController,
    required this.notesController,
    required this.categoryController,
    required this.tagsController,
    required this.promptTextError,
    required this.status,
    required this.onStatusChanged,
    required this.onPromptTextChanged,
    required this.onSubmit,
  });

  final PromptCard prompt;
  final TextEditingController titleController;
  final TextEditingController promptTextController;
  final TextEditingController descriptionController;
  final TextEditingController notesController;
  final TextEditingController categoryController;
  final TextEditingController tagsController;
  final String? promptTextError;
  final PromptStatus status;
  final ValueChanged<PromptStatus> onStatusChanged;
  final VoidCallback onPromptTextChanged;
  final ValueChanged<PromptCard> onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateState = ref.watch(promptEditControllerProvider);
    final isLoading = updateState.isLoading;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController,
                enabled: !isLoading,
                decoration: const InputDecoration(labelText: 'Baslik'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: promptTextController,
                enabled: !isLoading,
                minLines: 8,
                maxLines: 16,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  labelText: 'Prompt metni',
                  errorText: promptTextError,
                ),
                onChanged: (_) => onPromptTextChanged(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                enabled: !isLoading,
                decoration: const InputDecoration(labelText: 'Aciklama'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesController,
                enabled: !isLoading,
                minLines: 2,
                maxLines: 6,
                decoration: const InputDecoration(labelText: 'Notlar'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: categoryController,
                enabled: !isLoading,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: tagsController,
                enabled: !isLoading,
                decoration: const InputDecoration(
                  labelText: 'Etiketler',
                  hintText: 'etiket-1, etiket-2',
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<PromptStatus>(
                initialValue: status,
                decoration: const InputDecoration(labelText: 'Durum'),
                items: [
                  for (final status in PromptStatus.values)
                    DropdownMenuItem<PromptStatus>(
                      value: status,
                      child: Text(_statusLabel(status)),
                    ),
                ],
                onChanged: isLoading
                    ? null
                    : (value) {
                        if (value == null) {
                          return;
                        }

                        onStatusChanged(value);
                      },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: isLoading ? null : () => onSubmit(prompt),
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
    );
  }

  static String _statusLabel(PromptStatus status) {
    return switch (status) {
      PromptStatus.raw => 'Ham',
      PromptStatus.needsEdit => 'Duzenlenecek',
      PromptStatus.ready => 'Kullanima Hazir',
      PromptStatus.archived => 'Arsiv',
    };
  }
}

class _PromptEditNotFoundState extends StatelessWidget {
  const _PromptEditNotFoundState();

  @override
  Widget build(BuildContext context) {
    return const _CenteredMessage(
      icon: Icons.search_off_outlined,
      title: 'Prompt bulunamadi',
      message: 'Duzenlemek istediginiz prompt bulunamadi.',
    );
  }
}

class _PromptEditErrorState extends StatelessWidget {
  const _PromptEditErrorState();

  @override
  Widget build(BuildContext context) {
    return const _CenteredMessage(
      icon: Icons.error_outline,
      title: 'Prompt yuklenemedi',
      message: 'Baglantiyi kontrol edip tekrar deneyin.',
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  const _CenteredMessage({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 44, color: colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                title,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
