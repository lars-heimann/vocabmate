import '../../widgets/ankigpt_card.dart';
import '../../widgets/extensions.dart';
import '../../widgets/max_width_constrained_box.dart';
import '../../widgets/section_title.dart';
import '../../widgets/social_media_icon_button.dart';
import '../../providers/home_page_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutSection extends ConsumerWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaxWidthConstrainedBox(
      key: ref.read(homePageScrollViewProvider).aboutSectionKey,
      maxWidth: 850,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SectionTitle(title: 'About'),
            SizedBox(height: 48),
            _AboutCard(),
          ],
        ),
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: AnkiGptCard(
        padding: const EdgeInsets.all(0),
        child: context.isMobile ? const _MobileView() : const _DeskopView(),
      ),
    );
  }
}

class _MobileView extends StatelessWidget {
  const _MobileView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 275,
          width: MediaQuery.of(context).size.width,
          child: const _Picture(),
        ),
        const SizedBox(width: 12),
        const _Content(),
      ],
    );
  }
}

class _DeskopView extends StatelessWidget {
  const _DeskopView();

  @override
  Widget build(BuildContext context) {
    return const IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: _Picture(),
          ),
          SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: _Content(),
          ),
        ],
      ),
    );
  }
}

class _Picture extends StatelessWidget {
  const _Picture();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Image.asset(
        'assets/images/about-image.png',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Title(),
          SizedBox(height: 12),
          Text(
            "I'm Lars, I study Information Systems at the University of Münster.",
            style: textStyle,
          ),
          SizedBox(height: 14),
          Text(
            "The challenge of mastering a new language was daunting, consuming countless hours each week. That's why I created VocabMate. It's the perfect blend of AI magic and smart study techniques designed to revolutionize language learning. Jump in, and let's make your language journey a remarkable success, together.",
            style: textStyle,
          ),
          SizedBox(height: 14),
          SizedBox(height: 14),
          _SocialMedias(),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Hey there',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12),
        Image.asset(
          'assets/icons/waving-hand.png',
          height: 28,
        ),
      ],
    );
  }
}

class _SocialMedias extends StatelessWidget {
  const _SocialMedias();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SocialMediaIconButton(
          url: 'https://github.com/lars0530/',
          platform: SocialMediaPlatform.github,
        ),
        SizedBox(width: 12),
        SocialMediaIconButton(
          url: 'https://www.linkedin.com/in/larsheimann/',
          platform: SocialMediaPlatform.linkedin,
        ),
        SizedBox(width: 12),
      ],
    );
  }
}
