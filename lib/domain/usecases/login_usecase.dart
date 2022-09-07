import 'package:app_phrases/core/di/injection_container.dart';
import 'package:app_phrases/domain/entities/user_entity.dart';
import 'package:app_phrases/domain/repositories/auth_repository.dart';

class LoginUseCase {
  AuthRepository repository = get.get();

  Future<UserEntity> createAccountWithEmailPassword(
      String email, String password) {
    return repository.createAccountWithEmailPassword(email, password);
  }

  Future<UserEntity> loginWithEmailPassoword(String email, String password) {
    return repository.loginWithEmailPassoword(email, password);
  }
}
