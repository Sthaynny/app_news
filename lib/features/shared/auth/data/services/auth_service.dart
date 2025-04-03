import 'package:ufersa_hub/features/shared/auth/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final _log = Logger('AuthService');

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } catch (e) {
      _log.warning('Error signing up: $e');
      return null;
    }
  }

  // Sign in with email and password
  Future<UserModel?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user != null
          ? UserModel.fromFirebaseUser(userCredential.user!)
          : null;
    } catch (e) {
      _log.warning('Error signing in: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      _log.warning('Error signing out: $e');
    }
  }

  // Get current user
  UserModel? getCurrentUser() {
    try {
      return _firebaseAuth.currentUser != null
          ? UserModel.fromFirebaseUser(_firebaseAuth.currentUser!)
          : null;
    } catch (e) {
      _log.warning('Error getting current user: $e');
      return null;
    }
  }
}
