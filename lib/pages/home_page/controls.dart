import 'package:animations/animations.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabmate/pages/deck_page/error_card.dart';
import 'package:vocabmate/pages/home_page/options_dialog.dart';
import 'package:vocabmate/pages/home_page/plus_dialog.dart';
import 'package:vocabmate/providers/generate_provider.dart';
import 'package:vocabmate/providers/options_provider.dart';
import 'package:vocabmate/widgets/elevated_button.dart';
import 'package:vocabmate/widgets/extensions.dart';
import 'package:vocabmate/widgets/max_width_constrained_box.dart';
import 'package:vocabmate/services/openai_service.dart';

class Controls extends ConsumerWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          context.isMobile
              ? const _MobileControlsView()
              : const _DesktopControlsView(),
        ],
      ),
    );
  }
}

class _DesktopControlsView extends ConsumerWidget {
  const _DesktopControlsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final sessionId = ref.watch(sessionIdProvider);
    // final isWatching = sessionId != null;
    return const Row(
      children: [
        _ExportToAnkiButton(),
        Expanded(child: SizedBox()),
        // const _LoadingButton(),
        // if (!isWatching) ...[
        _OptionsButton(),
        SizedBox(width: 12),
        _GenerateButton(),
        // ] else
        //   const _CreateNewDeck(),
      ],
    );
  }
}

class _MobileControlsView extends ConsumerWidget {
  const _MobileControlsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final sessionId = ref.watch(sessionIdProvider);
    // final isWatching = sessionId != null;
    return const Column(
      children: [
        _ExportToAnkiButton(),
        SizedBox(height: 12),
        // if (!isWatching) ...[
        _OptionsButton(),
        SizedBox(height: 12),
        _GenerateButton(),
        // ] else
        //   const _CreateNewDeck(),
      ],
    );
  }
}

class _CreateNewDeck extends StatelessWidget {
  const _CreateNewDeck();

  @override
  Widget build(BuildContext context) {
    return AnkiGptElevatedButton.icon(
      tooltip: 'Create a new deck with a different input',
      icon: const Icon(Icons.add),
      label: const Text('New Deck'),
      border: Border.all(
        color: Colors.grey[400]!,
        width: 1.4,
      ),
      color: Colors.transparent,
      center: context.isMobile,
      // onPressed: () => context.pop(),
    );
  }
}

class _OptionsButton extends ConsumerWidget {
  const _OptionsButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: AnkiGptElevatedButton.icon(
        tooltip: 'Edit options (e.g. number of cards, model, target language)',
        icon: const Icon(Icons.tune),
        label: const Text('Options'),
        border: Border.all(
          color: Colors.grey[400]!,
          width: 1.4,
        ),
        color: Colors.transparent,
        center: context.isMobile,
        onPressed: () {
          showModal(
            context: context,
            builder: (context) => const OptionsDialog(),
            routeSettings: const RouteSettings(name: '/options'),
          );
        },
      ),
    );
  }
}

class _GenerateButton extends ConsumerWidget {
  const _GenerateButton();

  Future<void> generate(BuildContext context, WidgetRef ref) async {
    try {
      // final options = ref.watch(optionsControllerProvider);
      // final model = options.model.snakeCaseName;
      // final numOfCards = options.size.toInt();
      // final userId =
      //     'dCAl7a7DacRVoTYhRav2hdAcT7x1'; // ref.read(userIDProvider);
      // final userText =
      //     "La tour Eiffel La tour Eiffel est le symbole de la ville de Paris. Elle a été construite par Gustave Eiffel pour l’Exposition universelle de Paris de 1889. La tour Eiffel mesure exactement 312 mètres de hauteur. Lorsqu’elle a été construite, la tour Eiffel était le monument"; // ref.read(userTextProvider);
      // final explanationLanguage =
      //     'english'; // ref.read(explanationLanguageProvider);

      // // Call the ChatGptService method
      // await OpenAIService.generateAnkiCards(
      //   userId,
      //   userText,
      //   model, // Assuming `model` has a `name` or `toString` for the API
      //   explanationLanguage,
      //   numOfCards,
      await ref.read(generateNotifierProvider.notifier).submit();
    } catch (e) {
      if (!context.mounted) return;

      if (e is PlusMembershipRequiredException) {
        showPlusDialog(context);
        return;
      }

      if (e is TooShortInputException) {
        showModal(
          context: context,
          builder: (context) => const _TooLessInputDialog(),
        );
        return;
      }

      if (e is TooLongInputException) {
        showInputTooLong(context);
        return;
      }

      if (e is FreeLimitExceededException) {
        showPlusDialog(
          context,
          top: _FreeLimitExceededCard(
            currentDeckSize: e.currentDeckSize,
            remainingCardsForCurrentMonth: e.remainingFreeLimit,
          ),
        );
        return;
      }

      if (e is Gpt4LimitExceededException) {
        showPlusDialog(
          context,
          top: _Gpt4LimitExceededCard(
            currentDeckSize: e.currentDeckSize,
            remainingCardsForCurrentMonth: e.remainingGpt4Limit,
          ),
        );
        return;
      }

      context.showTextSnackBar('$e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGenerating = false; // ref.watch(isGeneratingProvider);

    final options = ref.watch(optionsControllerProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: AnkiGptElevatedButton.icon(
        key: ValueKey(isGenerating),
        tooltip: isGenerating
            ? 'Generating...'
            : 'Generate ${options.size.getUiText()} flashcards (${options.model.getUiText()})',
        icon: isGenerating ? null : const Icon(Icons.play_arrow),
        label: isGenerating
            ? const _GenerateButtonLoadingIndicator()
            : const Text('Generate'),
        center: context.isMobile,
        onPressed: isGenerating ? null : () => generate(context, ref),
      ),
    );
  }
}

class _GenerationErrorCard extends ConsumerWidget {
  const _GenerationErrorCard({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ErrorCard(
        text: message,
        onRetry: () => {},
      ),
    );
  }
}

class _FreeLimitExceededCard extends StatelessWidget {
  const _FreeLimitExceededCard({
    required this.currentDeckSize,
    required this.remainingCardsForCurrentMonth,
  });

  final int currentDeckSize;
  final int remainingCardsForCurrentMonth;

  @override
  Widget build(BuildContext context) {
    return _LimitExceededCard(text: '''**Limit reached!**

As a free user, you can create a maximum of $freeUsageLimitPerMonth cards per month. You have $remainingCardsForCurrentMonth remaining, but you attempted to generate $currentDeckSize cards. To produce more cards, consider upgrading to Plus.''');
  }
}

class _Gpt4LimitExceededCard extends StatelessWidget {
  const _Gpt4LimitExceededCard({
    required this.currentDeckSize,
    required this.remainingCardsForCurrentMonth,
  });

  final int currentDeckSize;
  final int remainingCardsForCurrentMonth;

  @override
  Widget build(BuildContext context) {
    return _LimitExceededCard(text: '''**Limit reached!**

You can create a maximum of $plusGpt4UsageLimitPerMonth cards with GPT-4 per month. You have $remainingCardsForCurrentMonth remaining, but you attempted to generate $currentDeckSize cards.''');
  }
}

class _LimitExceededCard extends StatelessWidget {
  const _LimitExceededCard({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MaxWidthConstrainedBox(
        maxWidth: 450,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange[100]!.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: MarkdownBody(
            data: text,
            styleSheet: MarkdownStyleSheet(
              p: const TextStyle(
                color: Colors.deepOrange,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GenerateButtonLoadingIndicator extends StatelessWidget {
  const _GenerateButtonLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 42, vertical: 2),
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ExportToAnkiButton extends ConsumerWidget {
  const _ExportToAnkiButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnkiGptElevatedButton.icon(
      tooltip: 'Export to Anki',
      icon: const Icon(Icons.download),
      label: const Text('Export to Anki'),
      center: context.isMobile,
      onPressed: () {
        // Dummy button, does nothing
      },
    );
  }
}

class _TooLessInputDialog extends StatelessWidget {
  const _TooLessInputDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Input too short!'),
      content: const Text(
          'Please add more text (min. 400 characters). If the text is too short, GPT cannot generate the flashcards.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
