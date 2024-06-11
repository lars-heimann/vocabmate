import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vocabmate/pages/flashcard_page.dart';
import 'package:vocabmate/pages/home_page.dart';
import 'package:vocabmate/pages/imprint.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  // final logger = ref.read(loggerProvider);
  return GoRouter(
    // observers: [
    //   NavigationLoggerObserver(logger),
    // ],
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          final zero = state.uri.queryParameters['0'];
          final has0Analytics = zero?.isEmpty ?? false;
          return VocabMateHomePage();
        },
        routes: [
          // GoRoute(
          //   path: 'account',
          //   builder: (context, state) => const AccountPage(),
          // ),
          GoRoute(
            path: 'imprint',
            builder: (context, state) => const ImprintPage(),
          ),
          // GoRoute(
          //   path: 'successful-plus-payment',
          //   redirect: (context, state) {
          //     _logPlusBought(ref);
          //     ref.read(showSuccessfulPaymentDialogProvider.notifier).set(true);
          //     return '/';
          //   },
          // ),
          GoRoute(
            path: 'cancel',
            redirect: (context, state) => '/',
          ),
          GoRoute(
            path: 'deck',
            builder: (context, state) {
              final arguments = state.extra as Map<String, dynamic>?;
              print('Navigating to deck with arguments: $arguments');
              return FlashCardPage(
                inputText: arguments?['inputText'] ?? '',
                flashCards: arguments?['flashCards'] ?? [],
              );
            },
          ),
          // GoRoute(
          //   path: 'import-from-gpt',
          //   builder: (context, state) {
          //     return const ImportFromGptPage();
          //   },
          // ),
        ],
      ),
    ],
  );
}

// void _logPlusBought(RouterRef ref) {
//   final analytics = ref.read(analyticsProvider);
//   unawaited(analytics.logEvent('plus_bought'));
// }

Uri getCurrentLocation(Ref ref) {
  final router = ref.read(routerProvider);
  final RouteMatch lastMatch = router.routerDelegate.currentConfiguration.last;
  final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
      ? lastMatch.matches
      : router.routerDelegate.currentConfiguration;
  return matchList.uri;
}
