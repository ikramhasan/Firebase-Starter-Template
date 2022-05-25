import 'package:dartz/dartz.dart';
import 'package:firebase_auth_starter/src/core/domain/entities/errors.dart';
import 'package:firebase_auth_starter/src/core/domain/entities/failures.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  bool isValid() => value.isRight();

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold((l) => left(l), (r) => right(unit));
  }

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() => value.fold((f) => throw UnexpectedValueError(f), id);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}
