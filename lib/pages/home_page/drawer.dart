import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabmate/providers/home_page_scroll_view.dart';
import 'package:vocabmate/widgets/ankigpt_logo.dart';
import 'package:vocabmate/widgets/scroll_to.dart';

class HomePageDrawer extends ConsumerWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const spaceBetweenItems = SizedBox(height: 12);
    final isSignedIn = false;
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceBetweenItems,
                    ListTile(
                      onTap: () {
                        final key = ref
                            .read(homePageScrollViewProvider)
                            .inputSectionKey;
                        scrollTo(context: context, key: key);
                        Navigator.pop(context);
                      },
                      title: const Text('Input'),
                    ),
                    spaceBetweenItems,
                    ListTile(
                      onTap: () {
                        final key = ref
                            .read(homePageScrollViewProvider)
                            .pricingSectionKey;
                        scrollTo(context: context, key: key);
                        Navigator.pop(context);
                      },
                      title: const Text('Pricing'),
                    ),
                    spaceBetweenItems,
                    ListTile(
                      onTap: () {
                        final key = ref
                            .read(homePageScrollViewProvider)
                            .aboutSectionKey;
                        scrollTo(context: context, key: key);
                        Navigator.pop(context);
                      },
                      title: const Text('About'),
                    ),
                    spaceBetweenItems,
                    ListTile(
                      onTap: () {
                        final key =
                            ref.read(homePageScrollViewProvider).faqSectionKey;
                        scrollTo(context: context, key: key);
                        Navigator.pop(context);
                      },
                      title: const Text('FAQ'),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                final key =
                    ref.read(homePageScrollViewProvider).inputSectionKey;
                scrollTo(context: context, key: key);
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: SizedBox(
                  height: 32,
                  child: AnkiGptTextLogo(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
