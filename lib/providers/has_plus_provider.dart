import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'has_plus_provider.g.dart';

AppUser({required bool hasPlus}) {}

@Riverpod(dependencies: [], keepAlive: true)
bool hasPlus(Ref ref) {
  final appUser = ref.watch(Provider((ref) => AppUser(hasPlus: false)));
  return appUser.value?.hasPlus ?? false;
}
