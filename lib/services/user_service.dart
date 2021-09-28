//Packages
import 'package:dio/dio.dart';

//User Exception
import '../exceptions/user_exception.dart';

//User Model
import '../models/user.dart';

class UserService {
  UserService(this._dio);

  final Dio _dio;

  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get(
        "https://jsonplaceholder.typicode.com/users",
      );

      final results = List<Map<String, dynamic>>.from(response.data);

      print ("<<<<<< Results $results");

      List<User> users = results
          .map((userData) => User.fromJson(userData))
          .toList(growable: false);

      return users;

    } on DioError catch (dioError) {
      throw UserException.fromDioError(dioError);
    }
  }
}
