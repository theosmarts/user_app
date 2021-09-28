//Packages
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//User Model
import '../models/user.dart';

//User Service
import '../services/user_service.dart';

final userServiceProvider = Provider<UserService>((ref) {
  return UserService(Dio());
});

final usersFutureProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  //we use autoDispose to reset the state when the user leaves the screen and re-enters it.
  ref.maintainState = true;
  //if the request failed and the user leaves the screen then re-enters it, then the request will be performed again
  final userService = ref.watch(userServiceProvider);
  final users = await userService.getUsers();
  return users;
});
