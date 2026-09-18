import 'dart:convert';

import '../Api/ApiConstants.dart';
import '../Api/ApiServices.dart';

abstract class SignupRepo {
  Future<void> signup({required Map<String, dynamic> body});
}

class SignupRepoImpl extends SignupRepo {
  final ApiServices apiServices = ApiServices();

  @override
  Future<void> signup({required Map<String, dynamic> body}) async {
    final endPoint =
        '${ApiConstants.baseUrl}'
        '${ApiConstants.apiVersion}'
        '${ApiConstants.module}'
        '${ApiConstants.registerEndPoint}';
    try {
      final response = await apiServices.post(endPoint: endPoint, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print(data.toString());
        print('success');
        return;
      }
      if (response.statusCode >= 400 && response.statusCode < 500) {
        final data = jsonDecode(response.body);
        print(data);
        throw Exception(data.toString());
      }
      throw Exception('Server Error: ${response.statusCode}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
