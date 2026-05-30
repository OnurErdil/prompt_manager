import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/prompt_card.dart';
import '../providers/prompt_providers.dart';

class PromptLibraryScreen extends ConsumerWidget {
  const PromptLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(authControllerProvider, (previous, next) {
      final wasLoading = previous?.isLoading ?? false;
      final isSuccess = wasLoading && next.hasValue && !next.isLoading;

      if (isSuccess) {
        context.go(RoutePaths.login);
      }

      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cikis yapilamadi. Tekrar deneyin.')),
        );
      }
    });

    final authActionState = ref.watch(authControllerProvider);
    final promptsState = ref.watch(currentUserPromptsProvider);
    final isSigningOut = authActionState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prompt Kutuphanesi'),
        actions: [
          IconButton(
            tooltip: 'Ayarlar',
            onPressed: () => context.go(RoutePaths.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
          IconButton(
            tooltip: 'Cikis yap',
            onPressed: isSigningOut
                ? null
                : () => ref.read(authControllerProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(RoutePaths.quickAddPrompt),
        icon: const Icon(Icons.add),
        label: const Text('Hizli Ekle'),
      ),
      body: SafeArea(
        child: promptsState.when(
          data: (prompts) {
            if (prompts.isEmpty) {
              return const _PromptLibraryEmptyState();
            }

            return _PromptList(prompts: prompts);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => const _PromptLibraryErrorState(),
        ),
      ),
    );
  }
}

class _PromptLibraryEmptyState extends StatelessWidget {
  const _PromptLibraryEmptyState();

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
              Icon(
                Icons.library_books_outlined,
                size: 48,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 20),
              Text(
                'Ilk promptunu yakala',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Tek bir prompt metniyle basla. Kaydettigin prompt burada gorunecek.',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => context.go(RoutePaths.quickAddPrompt),
                icon: const Icon(Icons.add),
                label: const Text('Ilk promptunu ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PromptLibraryErrorState extends StatelessWidget {
  const _PromptLibraryErrorState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 44, color: colorScheme.error),
              const SizedBox(height: 16),
              Text(
                'Promptlar yuklenemedi',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Baglantiyi kontrol edip tekrar deneyin.',
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

class _PromptList extends StatelessWidget {
  const _PromptList({required this.prompts});

  final List<PromptCard> prompts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
      itemBuilder: (context, index) {
        final prompt = prompts[index];
        return _PromptListItem(prompt: prompt);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: prompts.length,
    );
  }
}

class _PromptListItem extends StatelessWidget {
  const _PromptListItem({required this.prompt});

  final PromptCard prompt;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final preview = _previewText(prompt.promptText);

    return Material(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.42),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => context.go(RoutePaths.promptDetailLocation(prompt.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prompt.effectiveTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                preview,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Durum: ${prompt.status.key} | Guncel: ${_formatDate(prompt.updatedAt)}',
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _previewText(String promptText) {
    return promptText.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  static String _formatDate(DateTime value) {
    String twoDigits(int number) => number.toString().padLeft(2, '0');

    return '${value.year}-${twoDigits(value.month)}-${twoDigits(value.day)} '
        '${twoDigits(value.hour)}:${twoDigits(value.minute)}';
  }
}
