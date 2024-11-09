import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabmate/providers/router_provider.dart';
import 'package:vocabmate/widgets/theme.dart';
import 'package:wiredash/wiredash.dart';

Future<void> main() async {
  usePathUrlStrategy();

  // WidgetsFlutterBinding.ensureInitialized();

  // We need to create a provider container because at this point, we don't
  // have any widget or provider scope set. Therefore, we can only access
  // provider through the container.
  final container = ProviderContainer();

  // final memoryOutput = container.read(memoryOutputProvider);
  // final logger = container.read(loggerProvider);
  // final flavor = _getFlavor(logger);

  // FlutterError.onError = (details) {
  //   logger.e('FlutterError.onError',
  //       error: details.exception, stackTrace: details.stack);
  // };

  // await _initFirebase(flavor);

  // unawaited(zeroFlagSetter(logger));

  runApp(const ProviderScope(child: AnkiGptApp()));
}

// Flavor _getFlavor(Logger logger) {
//   final flavor = Flavor.values
//       .byName(const String.fromEnvironment('FLAVOR', defaultValue: 'prod'));
//   logger.i('Flavor: ${flavor.name}');
//   return flavor;
// }

// Future<FirebaseApp> _initFirebase(Flavor flavor) async {
//   switch (flavor) {
//     case Flavor.dev:
//       return Firebase.initializeApp(
//           options: dev.DefaultFirebaseOptions.currentPlatform);
//     case Flavor.prod:
//       return Firebase.initializeApp(
//           options: prod.DefaultFirebaseOptions.currentPlatform);
//   }
// }

// Future<void> zeroFlagSetter(Logger logger) async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   final auth = FirebaseAuth.instance;
//   auth.authStateChanges().listen((user) async {
//     if (user == null) {
//       return;
//     }

//     try {
//       final has0 = sharedPreferences.getBool('0') ?? false;
//       if (has0) {
//         final cloudFirestore = FirebaseFirestore.instance;
//         await cloudFirestore.doc('Users/${user.uid}').set({
//           'has0': true,
//         }, SetOptions(merge: true));
//         logger.i('Set has0 flag for user ${user.uid}');
//         return;
//       }
//     } catch (e) {
//       logger.e('Could not set has0 flag for user ${user.uid}', error: e);
//     }
//   });
// }

class AnkiGptApp extends ConsumerWidget {
  const AnkiGptApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Call shared preferences to initialize it.
    // ref.read(sharedPreferencesAccesserProvider);

    return MaterialApp.router(
      title: 'Vocabmate - Create vocab flashcards in seconds',
      theme: vocabMateTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider),
    );
  }
}

// class _WiredashSetup extends StatelessWidget {
//   const _WiredashSetup({
//     required this.child,
//     required this.flavor,
//   });

//   final Flavor flavor;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Wiredash(
//       projectId: switch (flavor) {
//         Flavor.dev => "ankigpt-dev-umsghy2",
//         Flavor.prod => "ankigpt-prod-2kkoogc",
//       },
//       secret: switch (flavor) {
//         // @Attackers: Please don't use the secret to spam the Wiredash project.
//         // I'm too lazy to pass the secret as an environment variable ¯\_(ツ)_/¯.
//         Flavor.dev => "IFjch7nx5Ex8Y3mDv_nwvzkWpt9be4cs",
//         Flavor.prod => "iWFVUeQA5RQxMDMoWFciRfcyI0ayRZZ8",
//       },
//       child: child,
//     );
//   }
// }
