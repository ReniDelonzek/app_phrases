import 'package:app_phrases/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> createAccountWithEmailPassword(
      String email, String password);

  Future<UserEntity> loginWithEmailPassoword(String email, String password);

  Future<String?> getToken({bool forceRefresh});

  Future<bool> isLogged();
}
