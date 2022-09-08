import 'package:app_phrases/data/datasources/auth_datasource.dart';
import 'package:app_phrases/data/datasources/remote_datasource.dart';
import 'package:app_phrases/data/repositories/auth_repository_impl.dart';
import 'package:app_phrases/domain/entities/user_entity.dart';
import 'package:app_phrases/domain/errors/errors.dart';
import 'package:app_phrases/domain/errors/exeptions.dart';
import 'package:app_phrases/domain/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../datasource/mocks/main_generate_test.mocks.dart';

void main() {
  AuthDatasource authDatasource = MockAuthDatasource();
  RemoteDatasource remoteDatasource = MockRemoteDatasource();
  AuthRepository authRepository = AuthRepositoryImpl(
      authDatasource: authDatasource, remoteDatasource: remoteDatasource);
  List<String> tokens = ['123', 'abc'];
  test('Test create account', () {
    when(authDatasource.createAccountWithEmailPassword(
            'wrong-email', 'wrong-pass'))
        .thenThrow(InvalidEmailException());
    when(authDatasource.createAccountWithEmailPassword(
            'alreadyexists@email.com', 'password'))
        .thenThrow(AlreadyExistsAccountException());

    when(authDatasource.createAccountWithEmailPassword(
            'validemail@gmail.com', 'weak'))
        .thenThrow(WeakPasswordException());

    when(authDatasource.createAccountWithEmailPassword(
            'validemail@gmail.com', 'validpass'))
        .thenAnswer((realInvocation) async => UserEntity(
            uid: '', email: 'validemail@gmail.com', name: 'Test Name'));

    // Retornar resposta diferente a cada chamada
    when(authDatasource.getToken()).thenAnswer((_) async => tokens.removeAt(0));
    when(remoteDatasource.updateTokenByUser('123')).thenAnswer(
        (realInvocation) async =>
            realInvocation.positionalArguments.first == '123');

    expect(
        () => authRepository.createAccountWithEmailPassword(
            'wrong-email', 'wrong-pass'),
        throwsA(isInstanceOf<InvalidEmailError>()));
    expect(
        () => authRepository.createAccountWithEmailPassword(
            'alreadyexists@email.com', 'password'),
        throwsA(isInstanceOf<AlreadyExistsEmailError>()));
    expect(
        () => authRepository.createAccountWithEmailPassword(
            'validemail@gmail.com', 'weak'),
        throwsA(isInstanceOf<WeakPasswordError>()));

    expect(
        () => authRepository.createAccountWithEmailPassword(
            'wrong-email', 'wrong-pass'),
        throwsA(isInstanceOf<InvalidEmailError>()));

    // Configurado para dar sucesso na primeira chamada
    // e falha ao atualizar o token na segunda chamada
    expect(
        authRepository.createAccountWithEmailPassword(
            'validemail@gmail.com', 'validpass'),
        isNotNull);
    expect(
        () => authRepository.createAccountWithEmailPassword(
            'validemail@gmail.com', 'validpass'),
        throwsA(isInstanceOf<ServerError>()));
  });
}
