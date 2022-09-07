class ServerException implements Exception {}

class AuthException implements Exception {}

class AlreadyExistsAccountException implements AuthException {}

class InvalidEmailException implements AuthException {}

class WeakPasswordException implements AuthException {}

class WrongPasswordException implements AuthException {}

class UserNotFoundException implements AuthException {}

class UserDisabledException implements AuthException {}
