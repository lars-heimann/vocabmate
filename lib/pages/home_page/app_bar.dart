import 'package:vocabmate/widgets/ankigpt_logo.dart';
import 'package:vocabmate/widgets/extensions.dart';
import 'package:vocabmate/widgets/scroll_to.dart';
import 'package:vocabmate/widgets/theme.dart';
import 'package:vocabmate/providers/home_page_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return context.isMobile
        ? const _AppBarSmallScreen()
        : const _AppBarLargeScreen();
  }
}

class _AppBarSmallScreen extends StatelessWidget {
  const _AppBarSmallScreen();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox(
        height: 1,
        child: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      centerTitle: true,
      title: const SizedBox(
        height: 40,
        child: AnkiGptTextLogo(),
      ),
      actions: const [
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: null,
        ),
      ],
    );
  }
}

class _AppBarLargeScreen extends ConsumerWidget {
  const _AppBarLargeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      leadingWidth: 150,
      leading: const Padding(
        padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
        child: AnkiGptTextLogo(),
      ),
      centerTitle: true,
      title: const _NavigationItems(),
      actions: const [
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: null,
        ),
      ],
    );
  }
}

class _NavigationItems extends ConsumerWidget {
  const _NavigationItems();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spaceBetweenItems = SizedBox(width: context.isDesktop ? 16 : 0);
    return Theme(
      data: Theme.of(context).copyWith(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            foregroundColor: deepViolet,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          spaceBetweenItems,
          TextButton(
            onPressed: () {
              final key =
                  ref.read(homePageScrollViewProvider).pricingSectionKey;
              scrollTo(context: context, key: key);
            },
            child: const Text('Pricing'),
          ),
          spaceBetweenItems,
          TextButton(
            onPressed: () {
              final key = ref.read(homePageScrollViewProvider).aboutSectionKey;
              scrollTo(context: context, key: key);
            },
            child: const Text('About'),
          ),
          spaceBetweenItems,
          TextButton(
            onPressed: () {
              final key = ref.read(homePageScrollViewProvider).faqSectionKey;
              scrollTo(context: context, key: key);
            },
            child: const Text('FAQ'),
          ),
        ],
      ),
    );
  }
}

class _DemoButton extends ConsumerWidget {
  const _DemoButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        final key = ref.read(homePageScrollViewProvider).demoSectionKey;
        scrollTo(context: context, key: key);
      },
      child: const Text('Demo'),
    );
  }
}

class _MyDecksButton extends ConsumerWidget {
  const _MyDecksButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        final key = ref.read(homePageScrollViewProvider).myDecksSectionKey;
        scrollTo(context: context, key: key);
      },
      child: const Text('My Decks'),
    );
  }
}
