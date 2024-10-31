import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vocabmate/models/card_generation_size.dart';
import 'package:vocabmate/models/model.dart';

part 'options_provider.freezed.dart';
part 'options_provider.g.dart';

@riverpod
class OptionsController extends _$OptionsController {
  static const defaultSize = CardGenerationSize.five;
  static const defaultModel = Model.gpt4o_mini;

  static const defaultOptions = GenerationOptions(
    size: defaultSize,
    model: defaultModel,
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
  }) = _GenerationOptions;

  /// Returns `true` if an option is selected, which requires AnkiGPT Plus.
  bool hasPlusOption() {
    return size.isPlus() || model.isPlus();
  }
}
