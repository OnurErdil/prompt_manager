import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../mappers/firebase_user_mapper.dart';
import '../services/firebase_auth_service.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._authService);

  final FirebaseAuthService _authService;

  @override
  Stream<AppUser?> authStateChanges() {
    return _authService.authStateChanges().map(
          (user) => user?.toAppUser(),
    );
  }

  @override
  AppUser? get currentUser {
    return _authService.currentUser?.toAppUser();
  }

  @override
  Future<AppUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final user = await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return user.toAppUser();
  }

  @override
  Future<AppUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final user = await _authService.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return user.toAppUser();
  }

  @override
  Future<void> signOut() {
    return _authService.signOut();
  }
}