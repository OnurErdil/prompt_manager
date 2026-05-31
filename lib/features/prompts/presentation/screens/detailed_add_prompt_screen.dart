import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../domain/enums/prompt_status.dart';
import '../providers/prompt_providers.dart';

class DetailedAddPromptScreen extends ConsumerStatefulWidget {
  const DetailedAddPromptScreen({super.key});

  @override
  ConsumerState<DetailedAddPromptScreen> createState() =>
      _DetailedAddPromptScreenState();
}

class _DetailedAddPromptScreenState
    extends ConsumerState<DetailedAddPromptScreen> {
  final _titleController = TextEditingController();
  final _promptTextController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _notesController = TextEditingController();
  final _categoryController = TextEditingController();
  final _tagsController = TextEditingController();

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
    ref.listen<AsyncValue<void>>(detailedAddPromptControllerProvider, (
      previous,
      next,
    ) {
      final wasLoading = previous?.isLoading ?? false;
      final isSuccess = wasLoading && next.hasValue && !next.isLoading;

      if (isSuccess) {
        ref.invalidate(currentUserPromptsProvider);
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

    final createState = ref.watch(detailedAddPromptControllerProvider);
    final isLoading = createState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Detayli Ekle')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    enabled: !isLoading,
                    decoration: const InputDecoration(labelText: 'Baslik'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _promptTextController,
                    enabled: !isLoading,
                    minLines: 8,
                    maxLines: 16,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      labelText: 'Prompt metni',
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
                  TextField(
                    controller: _descriptionController,
                    enabled: !isLoading,
                    decoration: const InputDecoration(labelText: 'Aciklama'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _notesController,
                    enabled: !isLoading,
                    minLines: 2,
                    maxLines: 6,
                    decoration: const InputDecoration(labelText: 'Notlar'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _categoryController,
                    enabled: !isLoading,
                    decoration: const InputDecoration(labelText: 'Kategori'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _tagsController,
                    enabled: !isLoading,
                    decoration: const InputDecoration(
                      labelText: 'Etiketler',
                      hintText: 'etiket-1, etiket-2',
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<PromptStatus>(
                    initialValue: _status,
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

                            setState(() {
                              _status = value;
                            });
                          },
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
    if (_promptTextController.text.trim().isEmpty) {
      setState(() {
        _promptTextError = 'Prompt metni bos olamaz.';
      });
      return;
    }

    ref
        .read(detailedAddPromptControllerProvider.notifier)
        .createPrompt(
          title: _titleController.text,
          promptText: _promptTextController.text,
          description: _descriptionController.text,
          notes: _notesController.text,
          category: _categoryController.text,
          tagsInput: _tagsController.text,
          status: _status,
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
