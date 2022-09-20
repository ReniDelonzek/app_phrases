import 'package:app_phrases/data/datasources/auth_datasource.dart';
import 'package:app_phrases/data/datasources/remote_datasource.dart';
import 'package:app_phrases/domain/entities/user_entity.dart';
import 'package:app_phrases/domain/errors/exeptions.dart';
import 'package:app_phrases/domain/repositories/auth_repository.dart';

import '../../domain/errors/errors.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthDatasource authDatasource;
  final RemoteDatasource remoteDatasource;
  AuthRepositoryImpl(
      {required this.authDatasource, required this.remoteDatasource});

  @override
  Future<UserEntity> createAccountWithEmailPassword(
      String email, String password) async {
    try {
      final result =
          await authDatasource.createAccountWithEmailPassword(email, password);
      if (await remoteDatasource.updateTokenByUser((await getToken())!)) {
        return result;
      } else {
        throw ServerError();
      }
    } catch (error, stackTrace) {
      if (error is AlreadyExistsAccountException) {
        throw AlreadyExistsEmailError(stackTrace: stackTrace);
      } else if (error is InvalidEmailException) {
        throw InvalidEmailError(stackTrace: stackTrace);
      } else if (error is WeakPasswordException) {
        throw WeakPasswordError(stackTrace: stackTrace);
      }
      throw ServerError();
    }
  }

  @override
  Future<UserEntity> loginWithEmailPassoword(
      String email, String password) async {
    try {
      final result =
          await authDatasource.loginWithEmailPassoword(email, password);
      return result;
    } catch (error, stackTrace) {
      if (error is InvalidEmailException) {
        throw InvalidEmailError(stackTrace: stackTrace);
      } else if (error is WrongPasswordException) {
        throw WrongPasswordError(stackTrace: stackTrace);
      } else if (error is UserNotFoundException) {
        throw UserNotFoundError(stackTrace: stackTrace);
      } else if (error is UserDisabledException) {
        throw UserDisabledError(stackTrace: stackTrace);
      }
      throw ServerError();
    }
  }

  @override
  Future<String?> getToken({bool forceRefresh = false}) {
    return authDatasource.getToken(forceRefresh: forceRefresh);
  }

  @override
  Future<bool> isLogged() {
    return authDatasource.isLogged();
  }

  @override
  Future<bool> logOut() {
    return authDatasource.logOut();
  }
}
