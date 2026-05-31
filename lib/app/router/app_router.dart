import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/auth_gate_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/prompts/presentation/screens/prompt_detail_screen.dart';
import '../../features/prompts/presentation/screens/prompt_edit_screen.dart';
import '../../features/prompts/presentation/screens/prompt_library_screen.dart';
import '../../features/prompts/presentation/screens/quick_add_prompt_screen.dart';
import '../../features/settings/presentation/screens/settings_placeholder_screen.dart';
import 'route_names.dart';

final appRouter = GoRouter(
  initialLocation: RoutePaths.authGate,
  routes: [
    GoRoute(
      path: RoutePaths.authGate,
      name: RouteNames.authGate,
      builder: (context, state) => const AuthGateScreen(),
    ),
    GoRoute(
      path: RoutePaths.login,
      name: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePaths.register,
      name: RouteNames.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: RoutePaths.library,
      name: RouteNames.library,
      builder: (context, state) => const PromptLibraryScreen(),
    ),
    GoRoute(
      path: RoutePaths.quickAddPrompt,
      name: RouteNames.quickAddPrompt,
      builder: (context, state) => const QuickAddPromptScreen(),
    ),
    GoRoute(
      path: RoutePaths.promptDetail,
      name: RouteNames.promptDetail,
      builder: (context, state) {
        final promptId = state.pathParameters['promptId'];

        return PromptDetailScreen(promptId: promptId ?? '');
      },
    ),
    GoRoute(
      path: RoutePaths.promptEdit,
      name: RouteNames.promptEdit,
      builder: (context, state) {
        final promptId = state.pathParameters['promptId'];

        return PromptEditScreen(promptId: promptId ?? '');
      },
    ),
    GoRoute(
      path: RoutePaths.settings,
      name: RouteNames.settings,
      builder: (context, state) => const SettingsPlaceholderScreen(),
    ),
  ],
);
