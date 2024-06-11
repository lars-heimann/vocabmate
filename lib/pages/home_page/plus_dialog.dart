import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vocabmate/pages/home_page/pricing_section.dart';
import 'package:vocabmate/widgets/ankigpt_card.dart';
import 'package:vocabmate/widgets/extensions.dart';
import 'package:vocabmate/widgets/max_width_constrained_box.dart';

void showPlusDialog(
  BuildContext context, {
  Widget? top,
}) {
  showModal(
    context: context,
    builder: (context) => PlusDialog(top: top),
    routeSettings: const RouteSettings(name: '/plus'),
  );
}

void showInputTooLong(BuildContext context) {
  showModal(
    context: context,
    builder: (context) => const TooLongInputDialog(),
    routeSettings: const RouteSettings(name: '/too-long-input'),
  );
}

class PlusDialog extends ConsumerWidget {
  const PlusDialog({
    super.key,
    this.top,
  });

  final Widget? top;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("Vocabmate Plus"),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 400,
            minHeight: 240,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (top != null) top!,
              const PlusAdvantages(),
              const SizedBox(height: 16),
              const _PlusPrice(),
            ],
          ),
        ),
      ),
      actions: const [
        _BuyButton(),
        _CancelButton(),
      ],
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Center(
        child: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
      ),
    );
  }
}

class PlusAdvantages extends StatelessWidget {
  const PlusAdvantages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SellingPoint(text: 'Unlimited cards per month'),
        SellingPoint(text: 'Up to 150 cards per deck'),
      ],
    );
  }
}

class _PlusPrice extends StatelessWidget {
  const _PlusPrice();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Price(
            priceEurPart: '€14',
            priceCentPart: '.99',
          ),
          Text(
            'Lifetime (one-time payment)',
            style: TextStyle(
              color: Colors.grey[700]!,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuyButton extends StatelessWidget {
  const _BuyButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          onPressed: () => showDevelopmentDialog(context),
          child: const Text('BUY'),
        ),
      ),
    );
  }
}

class TooLongInputDialog extends StatelessWidget {
  const TooLongInputDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaxWidthConstrainedBox(
      maxWidth: 500,
      child: AlertDialog(
        title: Text('Input too long!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnkiGptCard(
              color: Color(0xFFFFDFDF),
              child: Text(
                'Your text is too long. Free users have a limt of 4,000 characters. Buy Vocabmate Plus to remove this limit.',
                style: TextStyle(color: Color(0xFFD90000)),
              ),
            ),
            SizedBox(height: 16),
            PlusAdvantages(),
          ],
        ),
        actions: [
          _CancelButton(),
          _BuyButton(),
        ],
      ),
    );
  }
}
