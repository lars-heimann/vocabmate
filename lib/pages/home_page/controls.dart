import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabmate/widgets/elevated_button.dart';
import 'package:vocabmate/widgets/extensions.dart';

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
        onPressed: () {},
      ),
    );
  }
}

class _GenerateButton extends ConsumerWidget {
  const _GenerateButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: AnkiGptElevatedButton.icon(
        tooltip: 'Generate',
        icon: const Icon(Icons.play_arrow),
        label: const Text('Generate'),
        border: Border.all(
          color: Colors.grey[400]!,
          width: 1.4,
        ),
        center: context.isMobile,
        onPressed: () {
          // Dummy button, does nothing
        },
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
