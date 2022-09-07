// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on _LoginControllerBase, Store {
  late final _$showPasswordAtom =
      Atom(name: '_LoginControllerBase.showPassword', context: context);

  @override
  bool get showPassword {
    _$showPasswordAtom.reportRead();
    return super.showPassword;
  }

  @override
  set showPassword(bool value) {
    _$showPasswordAtom.reportWrite(value, super.showPassword, () {
      super.showPassword = value;
    });
  }

  late final _$loggingAtom =
      Atom(name: '_LoginControllerBase.logging', context: context);

  @override
  bool get logging {
    _$loggingAtom.reportRead();
    return super.logging;
  }

  @override
  set logging(bool value) {
    _$loggingAtom.reportWrite(value, super.logging, () {
      super.logging = value;
    });
  }

  late final _$loginModeAtom =
      Atom(name: '_LoginControllerBase.loginMode', context: context);

  @override
  bool get loginMode {
    _$loginModeAtom.reportRead();
    return super.loginMode;
  }

  @override
  set loginMode(bool value) {
    _$loginModeAtom.reportWrite(value, super.loginMode, () {
      super.loginMode = value;
    });
  }

  @override
  String toString() {
    return '''
showPassword: ${showPassword},
logging: ${logging},
loginMode: ${loginMode}
    ''';
  }
}
