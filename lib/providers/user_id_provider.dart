import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_id_provider.g.dart';

@Riverpod(keepAlive: true)
String? userId(UserIdRef ref) {
  return "abcdefghijk";
}
