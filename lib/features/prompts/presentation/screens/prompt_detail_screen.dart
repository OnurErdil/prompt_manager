import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/prompt_card.dart';
import '../providers/prompt_providers.dart';

class PromptDetailScreen extends ConsumerWidget {
  const PromptDetailScreen({required this.promptId, super.key});

  final String promptId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promptState = ref.watch(promptDetailProvider(promptId));

    return Scaffold(
      appBar: AppBar(title: const Text('Prompt Detay')),
      body: SafeArea(
        child: promptState.when(
          data: (prompt) {
            if (prompt == null) {
              return const _PromptNotFoundState();
            }

            return _PromptDetailData(prompt: prompt);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => const _PromptDetailErrorState(),
        ),
      ),
    );
  }
}

class _PromptDetailData extends StatelessWidget {
  const _PromptDetailData({required this.prompt});

  final PromptCard prompt;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Text(
          prompt.effectiveTitle,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () => _copyPromptText(context, prompt.promptText),
          icon: const Icon(Icons.copy_outlined),
          label: const Text('Normal Kopyala'),
        ),
        const SizedBox(height: 20),
        _DetailSection(
          title: 'Prompt metni',
          child: SelectableText(
            prompt.promptText,
            style: textTheme.bodyLarge?.copyWith(height: 1.45),
          ),
        ),
        if (_hasText(prompt.description)) ...[
          const SizedBox(height: 12),
          _DetailSection(
            title: 'Aciklama',
            child: Text(prompt.description!.trim()),
          ),
        ],
        if (_hasText(prompt.notes)) ...[
          const SizedBox(height: 12),
          _DetailSection(title: 'Notlar', child: Text(prompt.notes!.trim())),
        ],
        if (_hasText(prompt.category)) ...[
          const SizedBox(height: 12),
          _InfoRow(label: 'Kategori', value: prompt.category!.trim()),
        ],
        if (prompt.tags.isNotEmpty) ...[
          const SizedBox(height: 12),
          _ChipSection(title: 'Etiketler', values: prompt.tags),
        ],
        if (prompt.variables.isNotEmpty) ...[
          const SizedBox(height: 12),
          _ChipSection(title: 'Degiskenler', values: prompt.variables),
        ],
        const SizedBox(height: 12),
        _InfoRow(label: 'Durum', value: prompt.status.key),
        const SizedBox(height: 12),
        _InfoRow(label: 'Olusturuldu', value: _formatDate(prompt.createdAt)),
        const SizedBox(height: 12),
        _InfoRow(label: 'Guncellendi', value: _formatDate(prompt.updatedAt)),
        const SizedBox(height: 4),
        Text(
          'Kopyalama islemi prompt kaydini degistirmez.',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  static bool _hasText(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  static Future<void> _copyPromptText(
    BuildContext context,
    String promptText,
  ) async {
    await Clipboard.setData(ClipboardData(text: promptText));

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Prompt kopyalandi.')));
  }

  static String _formatDate(DateTime value) {
    String twoDigits(int number) => number.toString().padLeft(2, '0');

    return '${value.year}-${twoDigits(value.month)}-${twoDigits(value.day)} '
        '${twoDigits(value.hour)}:${twoDigits(value.minute)}';
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.42),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 112,
              child: Text(
                label,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChipSection extends StatelessWidget {
  const _ChipSection({required this.title, required this.values});

  final String title;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final value in values)
              Chip(
                label: Text(value),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _PromptNotFoundState extends StatelessWidget {
  const _PromptNotFoundState();

  @override
  Widget build(BuildContext context) {
    return const _CenteredMessage(
      icon: Icons.search_off_outlined,
      title: 'Prompt bulunamadi',
      message: 'Bu prompt silinmis veya erisiminiz olmayan bir kayit olabilir.',
    );
  }
}

class _PromptDetailErrorState extends StatelessWidget {
  const _PromptDetailErrorState();

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
