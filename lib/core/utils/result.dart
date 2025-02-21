// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Utility class to wrap result data
///
/// Evaluate the result using a switch statement:
/// ```dart
/// switch (result) {
///   case Ok(): {
///     print(result.value);
///   }
///   case Error(): {
///     print(result.error);
///   }
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.ok([T? value]) = Ok._;

  /// Creates an error [Result], completed with the specified [error].
  const factory Result.error(Exception error) = Error._;

  /// Creates an error [Result], completed with the specified [error] wiht message.
  factory Result.errorDefault(String message) => Error._(Exception(message));
}

/// Subclass of Result for values
final class Ok<T> extends Result<T> {
  const Ok._([this.value]);

  /// Returned value in result
  final T? value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// Subclass of Result for errors
final class Error<T> extends Result<T> {
  const Error._(this.error);

  /// Returned error in result
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}

extension ResultX<T> on Result<T> {
  /// Returns true if the result is [Ok]
  bool get isOk => this is Ok;

  /// Returns true if the result is [Error]
  bool get isError => this is Error;

  /// Returns the value if the result is [Ok]
  T? get value => (this as Ok?)?.value;

  /// Returns the error if the result is [Error]
  Exception get error => (this as Error).error;
}
