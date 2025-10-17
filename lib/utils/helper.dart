import 'package:flutter/material.dart';

class AppHelper {
  /// Handles async operations with automatic try-catch and logging.
  /// [operation] is the async function to run.
  /// [context] is optional, used to show a SnackBar on error.
  /// [errorMessage] is an optional message for the SnackBar.
  /// [fallback] is the value to return if the operation fails.
  static Future<T?> handleAsync<T>({
    required Future<T> Function() operation,
    BuildContext? context,
    String? errorMessage,
    T? fallback,
  }) async {
    try {
      return await operation();
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('$stackTrace');

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage ?? 'Something went wrong')),
        );
      }

      return fallback;
    }
  }
}
