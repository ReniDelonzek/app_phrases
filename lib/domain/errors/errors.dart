class ServerError {}

class AuthError implements Error {
  @override
  StackTrace? stackTrace;

  AuthError({
    required this.stackTrace,
  });
}

class AlreadyExistsEmailError implements AuthError {
  @override
  StackTrace? stackTrace;
  AlreadyExistsEmailError({
    this.stackTrace,
  });
}

class InvalidEmailError implements AuthError {
  @override
  StackTrace? stackTrace;
  InvalidEmailError({
    this.stackTrace,
  });
}

class WeakPasswordError implements AuthError {
  @override
  StackTrace? stackTrace;
  WeakPasswordError({
    this.stackTrace,
  });
}

class WrongPasswordError implements AuthError {
  @override
  StackTrace? stackTrace;
  WrongPasswordError({
    this.stackTrace,
  });
}

class UserNotFoundError implements AuthError {
  @override
  StackTrace? stackTrace;
  UserNotFoundError({
    this.stackTrace,
  });
}

class UserDisabledError implements AuthError {
  @override
  StackTrace? stackTrace;
  UserDisabledError({
    this.stackTrace,
  });
}
