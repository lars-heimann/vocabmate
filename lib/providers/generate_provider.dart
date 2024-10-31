import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:vocabmate/models/card_generation_size.dart';
import 'package:vocabmate/models/generate_state.dart';
import 'package:vocabmate/models/model.dart';
import 'package:vocabmate/providers/has_plus_provider.dart';
import 'package:vocabmate/providers/input_text_field_controller.dart';
import 'package:vocabmate/providers/options_provider.dart';
import 'package:vocabmate/providers/router_provider.dart';
import 'package:vocabmate/services/openai_service.dart';

part 'generate_provider.g.dart';

/// Defines the number of cards every free user has per month available.
const freeUsageLimitPerMonth = 100;

const freeMnemonicsUsagePerMonth = 5;

const plusGpt4UsageLimitPerMonth = 500;

@Riverpod(keepAlive: true)
class GenerateNotifier extends _$GenerateNotifier {
  // Logger get _logger => ref.read(loggerProvider);
  TextEditingController get _textEditingController =>
      ref.read(inputTextFieldControllerProvider);
  // UserRepository get _userRepository => ref.read(userRepositoryProvider);
  // SessionRepository get _sessionRepository =>
  //     ref.read(sessionRepositoryProvider);
  bool get _hasPlus => ref.read(hasPlusProvider);
  int get _currentMonthUsage => 200; // => ref.read(currentMonthUsageProvider);
  int get _currentGpt4Usage => 1; //ref.read(currentGpt4UsageProvider);
  // Analytics get _analytics => ref.read(analyticsProvider);
  // static const _analyticsPage = 'generate';

  // PlatformFile? _pickedFile;
  // bool get _hasPickedFile => _pickedFile != null;
  // String? _pdfPassword;

  @override
  GenerateState build() {
    return const GenerateState.initial();
  }

  Future<void> submit() async {
    final options = ref.read(optionsControllerProvider);

    // _logger.d("Generating cards...");

    // if (!_hasPlus && options.hasPlusOption()) {
    //   print("Plus membership required but not available");
    //   // _logPlusRequiredToGenerate();
    //   throw PlusMembershipRequiredException();
    // }

    final text = _textEditingController.text;
    // if (!_hasPickedFile) {
    //   _throwIfTextInputIsInvalid(text);
    // }

    // _throwIfFreeLimitReached(options.size);
    // _throwIfGpt4LimitReached(options.size, options.model);

    // This code requires the user to have an account (anonymous doesn't count).
    // if (!ref.read(hasAccount2Provider)) {
    //   ref.read(wantsToGenerateProvider.notifier).set(true);
    //   ref.read(routerProvider).go('/account');
    //   return;
    // }

    state = const GenerateState.loading();

    try {
      final userId = const Uuid().v4();
      final model = options.model.snakeCaseName;
      final numOfCards = options.size.toInt();
      const explanationLanguage = 'english';
      final userText = text;

      await OpenAIService.generateAnkiCards(
        userId,
        userText,
        model,
        explanationLanguage,
        numOfCards,
      );

      // Reset state
      state = const GenerateState.initial();
      _textEditingController.clear();
      // _pdfPassword = null;
      ref.read(optionsControllerProvider.notifier).reset();

      final router = ref.read(routerProvider);
      router.go('/deck/');
    } catch (e, s) {
      print(e);
    }
  }
}

// String _getErrorMessageForFunctionsException(FirebaseFunctionsException e) {
//   if (e.message == 'too-long-input-exception') {
//     return 'Your input is too long. Please try again with a shorter input.';
//   }

//   if (e.message == 'too-less-input-exception') {
//     return 'Your input is too short. Please try again with a longer input (at least 400 characters). In case you uploaded a file, ensure that the file contains enough text (text from images is not supported). Or copy the text from the file and paste it into the text field.';
//   }

//   if (e.message == 'no-input-provided-exception') {
//     return 'The provided input was empty. Please try again with a non-empty input. In case you uploaded a file, ensure that the file contains enough text (text from images is not supported). Or copy the text from the file and paste it into the text field.';
//   }

//   if (e.message == 'could-not-read-pdf-exception') {
//     return 'The provided file could not be read. Please try again with a different file. Or copy the text from the file and paste it into the text field.';
//   }

//   if (e.message == 'unknown-language-exception') {
//     return 'It was not possible to detect the language of the input. Please try again with a different input. In case you uploading a file, ensure that the file contains enough text (text from images is not supported). Also, it could be that the text in your file is not readable by our OCR. In this case, please copy the text from the file and paste it into the text field.';
//   }

//   return 'An unknown error occurred. Please try again or contact the support.';
// }

// void _throwIfFreeLimitReached(CardGenerationSize size) {
//   if (!_hasPlus) {
//     final remainingFreeLimit = freeUsageLimitPerMonth - _currentMonthUsage;
//     if (remainingFreeLimit < size.toInt()) {
//       _logFreeLimitExceeded();
//       throw FreeLimitExceededException(
//         currentDeckSize: size.toInt(),
//         remainingFreeLimit: remainingFreeLimit,
//       );
//     }
//   }
// }

// void _throwIfGpt4LimitReached(CardGenerationSize size, Model model) {
//   if (_hasPlus && model == Model.gpt4o) {
//     final remainingGpt4Limit = plusGpt4UsageLimitPerMonth - _currentGpt4Usage;
//     if (remainingGpt4Limit < size.toInt()) {
//       throw Gpt4LimitExceededException(
//         currentDeckSize: size.toInt(),
//         remainingGpt4Limit: remainingGpt4Limit,
//       );
//     }
//   }
// }

// void _throwIfTextInputIsInvalid(String text) {
//   if (text.length < 400) {
//     _logTooShortInput();
//     throw TooShortInputException();
//   }

//   if (text.length > 4000 && !_hasPlus) {
//     _logTooLongInputWithoutPlus();
//     throw TooLongInputException();
//   }
// }

// void setPassword(String? password) {
//   _pdfPassword = password;
// }

// void reset() {
//   state = const GenerateState.initial();
//   ref.read(clearSessionStateProvider.notifier).clear();
// }

class TooShortInputException implements Exception {}

class TooLongInputException implements Exception {}

class PlusMembershipRequiredException implements Exception {}

class FreeLimitExceededException implements Exception {
  const FreeLimitExceededException({
    required this.currentDeckSize,
    required this.remainingFreeLimit,
  });

  /// The deck size that the user tried to generate.
  final int currentDeckSize;

  /// The number of cards the user has left in the free version.
  final int remainingFreeLimit;
}

class Gpt4LimitExceededException implements Exception {
  const Gpt4LimitExceededException({
    required this.currentDeckSize,
    required this.remainingGpt4Limit,
  });

  /// The deck size that the user tried to generate.
  final int currentDeckSize;

  /// The number of cards the user has left for GPT-4o.
  final int remainingGpt4Limit;
}
