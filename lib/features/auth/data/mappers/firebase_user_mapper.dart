import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../domain/entities/app_user.dart';

extension FirebaseUserMapper on firebase_auth.User {
  AppUser toAppUser() {
    return AppUser(
      id: uid,
      email: email,
    );
  }
}