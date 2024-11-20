import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vocabmate/models/card_generation_size.dart';
import 'package:vocabmate/models/model.dart';
import 'package:vocabmate/models/target_language.dart';

part 'options_provider.freezed.dart';
part 'options_provider.g.dart';

@riverpod
class OptionsController extends _$OptionsController {
  static const defaultSize = CardGenerationSize.five;
  static const defaultModel = Model.gpt4o_mini;
  static const defaultLanguage = TargetLanguage.english;

  static const defaultOptions = GenerationOptions(
    size: defaultSize,
    model: defaultModel,
    language: defaultLanguage,
  );

  @override
  GenerationOptions build() {
    return defaultOptions;
  }

  void setSize(CardGenerationSize size) {
    state = state.copyWith(size: size);
  }

  void setModel(Model model) {
    state = state.copyWith(model: model);
  }

  void setLanguage(TargetLanguage language) {
    // Add method to set language
    state = state.copyWith(language: language);
  }

  void reset() {
    state = defaultOptions;
  }
}

@freezed
class GenerationOptions with _$GenerationOptions {
  const GenerationOptions._();

  const factory GenerationOptions({
    required CardGenerationSize size,
    required Model model,
    required TargetLanguage language, // Add language to options
  }) = _GenerationOptions;

  /// Returns `true` if an option is selected, which requires AnkiGPT Plus.
  bool hasPlusOption() {
    return size.isPlus() || model.isPlus();
  }
}
