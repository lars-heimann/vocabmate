import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'has_plus_provider.g.dart';

AppUser({required bool hasPlus}) {}

@Riverpod(dependencies: [], keepAlive: true)
bool hasPlus(HasPlusRef ref) {
  final appUser = ref.watch(Provider((ref) => AppUser(hasPlus: false)));
  return appUser.value?.hasPlus ?? false;
}
