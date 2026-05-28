import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class FirebaseAuthService {
  FirebaseAuthService({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<firebase_auth.User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  firebase_auth.User? get currentUser => _firebaseAuth.currentUser;

  Future<firebase_auth.User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user == null) {
      throw StateError('Firebase Auth kullanıcı bilgisi döndürmedi.');
    }

    return user;
  }

  Future<firebase_auth.User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user == null) {
      throw StateError('Firebase Auth kullanıcı bilgisi döndürmedi.');
    }

    return user;
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}