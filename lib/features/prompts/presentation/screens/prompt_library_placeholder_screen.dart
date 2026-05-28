import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class PromptLibraryPlaceholderScreen extends ConsumerWidget {
  const PromptLibraryPlaceholderScreen({super.key});

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
          SnackBar(content: Text('Çıkış başarısız: ${next.error}')),
        );
      }
    });

    final authActionState = ref.watch(authControllerProvider);
    final isLoading = authActionState.isLoading;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prompt Kütüphanesi'),
        actions: [
          IconButton(
            tooltip: 'Ayarlar',
            onPressed: () => context.go(RoutePaths.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
          IconButton(
            tooltip: 'Çıkış yap',
            onPressed: isLoading
                ? null
                : () => ref.read(authControllerProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
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
                    'Kütüphane hazır',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Prompt kartları ve kayıt akışı M4 içinde eklenecek. Şimdilik auth ve routing akışı güvenli şekilde çalışıyor.',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    onPressed: () => context.go(RoutePaths.settings),
                    icon: const Icon(Icons.settings_outlined),
                    label: const Text('Ayarları aç'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
