import 'package:http/http.dart' as http;
import 'UsersClass.dart';


class UsersService {
  static const String url = "https://jsonplaceholder.typicode.com/users";
  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
print(response.statusCode);
    if (200 == response.statusCode) {
      final List<User> users = usersFromJson(response.body);
print(response.body);
      return users;
    } else {
      throw Exception("Bir hata oluştu");
    }
  }

}
