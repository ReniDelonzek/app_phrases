import 'package:app_phrases/domain/entities/user_entity.dart';
import 'package:app_phrases/domain/errors/exeptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDatasource {
  Future<UserEntity> createAccountWithEmailPassword(
      String email, String password);

  Future<UserEntity> loginWithEmailPassoword(String email, String password);

  Future<String?> getToken({bool forceRefresh = false});

  Future<bool> isLogged();
}

class AuthDatasourceFirebase implements AuthDatasource {
  @override
  Future<UserEntity> createAccountWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return UserEntity(
          uid: result.user!.uid,
          email: result.user!.email,
          name: result.user!.displayName);
    } catch (error) {
      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-use') {
          throw AlreadyExistsAccountException();
        } else if (error.code == 'invalid-email') {
          throw InvalidEmailException();
        } else if (error.code == 'weak-password') {
          throw WeakPasswordException();
        }
      }
      throw AuthException();
    }
  }

  @override
  Future<UserEntity> loginWithEmailPassoword(
      String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return UserEntity(
          uid: result.user!.uid,
          email: result.user!.email,
          name: result.user!.displayName);
    } catch (error) {
      if (error is FirebaseAuthException) {
        if (error.code == 'invalid-email') {
          throw InvalidEmailException();
        } else if (error.code == 'user-disabled') {
          throw UserDisabledException();
        } else if (error.code == 'user-not-found') {
          throw UserNotFoundException();
        } else if (error.code == 'wrong-password') {
          throw WrongPasswordException();
        }
      }
      throw AuthException();
    }
  }

  @override
  Future<String?> getToken({bool forceRefresh = false}) async {
    return (await FirebaseAuth.instance.currentUser
            ?.getIdToken(forceRefresh)) ??
        '';
  }

  @override
  Future<bool> isLogged() async {
    return FirebaseAuth.instance.currentUser != null;
  }
}
