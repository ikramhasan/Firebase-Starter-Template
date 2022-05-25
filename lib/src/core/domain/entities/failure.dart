import 'package:freezed_annotation/freezed_annotation.dart';

part '../failure.freezed.dart';
part '../failure.g.dart';

@freezed
class Failure with _$Failure {
  const factory Failure({
    required String message,
    required int code,
  }) = _Failure;

  factory Failure.general() => const Failure(
        message:
            'Something went wrong. Please try again. File a bug report if the problem persists',
        code: 101,
      );

  factory Failure.fromJson(Map<String, dynamic> json) =>
      _$FailureFromJson(json);

  factory Failure.none() => const _Failure(code: 0, message: '');
}
