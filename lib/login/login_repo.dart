import 'dart:convert';

import '../Api/ApiConstants.dart';
import '../Api/ApiServices.dart';
import '../cashe_helper.dart';

abstract class LoginRepo {
  Future<void> login({required Map<String, dynamic> body});
}

class LoginRepoImpl extends LoginRepo {
  final ApiServices apiServices = ApiServices();

  @override
  Future<void> login({required Map<String, dynamic> body}) async {
    final endPoint =
        '${ApiConstants.baseUrl}'
        '${ApiConstants.apiVersion}'
        '${ApiConstants.module}'
        '${ApiConstants.loginEndPoint}';

    try {
      final response = await apiServices.post(endPoint: endPoint, body: body);

      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        final token = data['data']['token'];
        final username = data['data']['username'];

        await CacheHelper.setUserToken(token);
        await CacheHelper.setUserName(username);

        await CacheHelper.setUserToken(token);

        print('Login Success');
        print('Token saved successfully');

        return;
      }

      if (response.statusCode >= 400 && response.statusCode < 500) {
        final data = jsonDecode(response.body);

        throw Exception(data['message'] ?? 'Login failed');
      }

      throw Exception('Server Error: ${response.statusCode}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
