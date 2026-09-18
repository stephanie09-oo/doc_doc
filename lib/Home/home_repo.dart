import 'dart:convert';

import '../Api/ApiConstants.dart';
import '../Api/ApiServices.dart';
import '../cashe_helper.dart';

class HomeRepo {
  final ApiServices apiServices = ApiServices();

  Future<Map<String, dynamic>> getHomeData() async {
    final endPoint =
        '${ApiConstants.baseUrl}'
        '${ApiConstants.apiVersion}'
        '${ApiConstants.homeEndPoint}';
    final token = CacheHelper.getUserToken();
    final response = await apiServices.get(
      endPoint: endPoint,
      header: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Home Status Code: ${response.statusCode}');
    print('Home Response: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception(
      'Failed to get home data: ${response.statusCode}',
    );
  }
}