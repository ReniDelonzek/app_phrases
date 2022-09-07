import 'package:app_phrases/core/di/injection_container.dart';
import 'package:app_phrases/domain/entities/user_entity.dart';
import 'package:app_phrases/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final AuthRepository repository = get.get();
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController ctlEmail = TextEditingController();
  final TextEditingController ctlPassword = TextEditingController();
  @observable
  bool showPassword = false;
  @observable
  bool logging = false;
  @observable
  bool loginMode = false;

  Future<UserEntity> createAccountEmailPassword(
      String email, String password) async {
    logging = true;
    try {
      final result =
          await repository.createAccountWithEmailPassword(email, password);
      return result;
    } catch (_) {
      rethrow;
    } finally {
      logging = false;
    }
  }

  Future<UserEntity> loginEmailPassword(String email, String password) async {
    logging = true;
    try {
      final result = await repository.loginWithEmailPassoword(email, password);
      return result;
    } catch (_) {
      rethrow;
    } finally {
      logging = false;
    }
  }
}
