abstract final class RouteNames {
  static const authGate = 'authGate';
  static const login = 'login';
  static const register = 'register';
  static const library = 'library';
  static const quickAddPrompt = 'quickAddPrompt';
  static const promptDetail = 'promptDetail';
  static const settings = 'settings';
}

abstract final class RoutePaths {
  static const authGate = '/';
  static const login = '/login';
  static const register = '/register';
  static const library = '/library';
  static const quickAddPrompt = '/library/quick-add';
  static const promptDetail = '/library/:promptId';
  static const settings = '/settings';

  static String promptDetailLocation(String promptId) {
    return '/library/$promptId';
  }
}
