import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabmate/providers/home_page_scroll_view.dart';
import 'package:vocabmate/widgets/ankigpt_card.dart';
import 'package:vocabmate/widgets/elevated_button.dart';
import 'package:vocabmate/widgets/scroll_to.dart';
import 'package:vocabmate/widgets/section_title.dart';

bool _isMobileView(BuildContext context) =>
    MediaQuery.of(context).size.width < 840;

class PricingSection extends ConsumerWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      key: ref.read(homePageScrollViewProvider).pricingSectionKey,
      children: [
        const SectionTitle(title: 'Pricing'),
        const SizedBox(height: 48),
        _isMobileView(context) ? const _MobileView() : const _DesktopView()
      ],
    );
  }
}

class _MobileView extends StatelessWidget {
  const _MobileView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _FreeTier(),
          SizedBox(height: 32),
          _PlusTier(),
        ],
      ),
    );
  }
}

class _DesktopView extends StatelessWidget {
  const _DesktopView();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _FreeTier(),
        SizedBox(width: min(48, MediaQuery.of(context).size.width * 0.025)),
        const _PlusTier(),
      ],
    );
  }
}

class _FreeTier extends ConsumerWidget {
  const _FreeTier();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _TierBase(
      name: 'Free',
      priceEurPart: '€0',
      points: const [
        PointData(
          '100 cards per month',
        ),
        PointData('Up to 50 cards per deck'),
      ],
      onPressedCallToAction: () {
        final key = ref.read(homePageScrollViewProvider).inputSectionKey;
        scrollTo(context: context, key: key);
      },
      callToActionText: 'Get started',
    );
  }
}

class _PlusTier extends ConsumerWidget {
  const _PlusTier();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _TierBase(
      name: 'Plus',
      priceEurPart: '€14',
      priceCentPart: '.99',
      priceDescription: 'Lifetime (one-time payment)',
      points: const [
        PointData(
          'Unlimited cards per month',
        ),
        PointData('Up to 150 cards per deck'),
      ],
      onPressedCallToAction: () {
        showDevelopmentDialog(context);
      },
      callToActionText: 'Upgrade now',
    );
  }
}

void showDevelopmentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Coming Soon!'),
        content: const Text(
            'Vocabmate Plus is currently still under development.\nYou may use all of the free tier options.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

// class _PlusTier extends ConsumerWidget {
//   const _PlusTier();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return _TierBase(
//       name: 'Plus',
//       priceEurPart: '€9',
//       priceCentPart: '.99',
//       priceDescription: 'Lifetime (one-time payment)',
//       points: const [
//         PointData(
//           'Unlimited cards per month',
//         ),
//         PointData('Up to 150 cards per deck'),
//       ],
//       onPressedCallToAction: () {
//         _showDevelopmentDialog(context);
//       },
//       callToActionText: 'Upgrade now',
//     );
//   }
// }

class _TierBase extends StatelessWidget {
  const _TierBase({
    required this.name,
    required this.priceEurPart,
    this.priceCentPart,
    required this.points,
    required this.onPressedCallToAction,
    required this.callToActionText,
    this.priceDescription,
    this.isEnabled = true,
  });

  final String name;
  final String priceEurPart;
  final String? priceCentPart;
  final String? priceDescription;
  final List<PointData> points;
  final VoidCallback onPressedCallToAction;
  final String callToActionText;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return AnkiGptCard(
      child: SizedBox(
        width: _isMobileView(context)
            ? MediaQuery.of(context).size.width * 0.85
            : 365,
        height: _isMobileView(context) ? 350 : 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Price(
                    priceEurPart: priceEurPart,
                    priceCentPart: priceCentPart,
                  ),
                  Text(priceDescription ?? ''),
                ],
              ),
            ),
            ...points.map(
              (point) => SellingPoint(
                text: point.text,
                trailing: point.trailing,
                description: point.description,
              ),
            ),
            const Expanded(child: SizedBox()),
            _CallToActionButton(
              onPressed: onPressedCallToAction,
              text: callToActionText,
              isEnabled: isEnabled,
            )
          ],
        ),
      ),
    );
  }
}

class Price extends StatelessWidget {
  const Price({
    super.key,
    required this.priceEurPart,
    required this.priceCentPart,
  });

  final String priceEurPart;
  final String? priceCentPart;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          priceEurPart,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (priceCentPart != null)
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 11),
            child: Text(
              priceCentPart!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600]!,
              ),
            ),
          )
      ],
    );
  }
}

class _CallToActionButton extends StatelessWidget {
  const _CallToActionButton({
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return AnkiGptElevatedButton(
      isEnabled: isEnabled,
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class SellingPoint extends StatelessWidget {
  const SellingPoint({
    super.key,
    required this.text,
    this.description,
    this.trailing,
  });

  final String text;
  final String? description;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        leading: const Icon(
          Icons.check,
          color: Colors.green,
        ),
        title: Text(text),
        trailing: trailing,
        subtitle: description != null ? Text(description!) : null,
      ),
    );
  }
}

class PointData {
  final String text;
  final String? description;
  final Widget? trailing;

  const PointData(
    this.text, {
    this.trailing,
    this.description,
  });
}
