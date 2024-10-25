import 'dart:math';

import 'package:vocabmate/pages/home_page/controls.dart';
import 'package:vocabmate/providers/home_page_scroll_view.dart';
import 'package:vocabmate/widgets/input_text_field.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabmate/widgets/max_width_constrained_box.dart';

class InputSection extends ConsumerWidget {
  const InputSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaxWidthConstrainedBox(
      key: ref.read(homePageScrollViewProvider).inputSectionKey,
      maxWidth: 850,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const _Headline(),
            const InputTextField(),
            const Controls(),
          ],
        ),
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: min(35, MediaQuery.of(context).size.width * 0.1),
        bottom: 52,
      ),
      child: const Column(
        children: [
          AutoSizeText(
            'Turn foreign texts\ninto Anki flashcards.',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }
}
