import 'package:firebase_auth_starter/src/core/domain/entities/failures.dart';

class NotAuthenticatedError extends Error {}

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable pont. Terminating.';

    return Error.safeToString('$explanation Failure was: $ValueFailure');
  }
}
