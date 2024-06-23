import 'package:assets_manager/data/exceptions.dart';
import 'package:dio/dio.dart';

class MyRDS {
  MyRDS({
    required this.url,
    required this.dio,
  });

  final String url;
  final Dio dio;

  Future<List<dynamic>> getCompanies() async {
    final response = await dio.get('$url/companies');
    if (response.data != null && response.statusCode == 200) {
      return response.data as List<dynamic>;
    } else {
      throw NetworkException();
    }
  }

  Future<List<dynamic>> getLocations(String companyId) async {
    final response = await dio.get('$url/companies/$companyId/locations');
    if (response.data != null && response.statusCode == 200) {
      return response.data as List<dynamic>;
    } else {
      throw NetworkException();
    }
  }

  Future<List<dynamic>> getAssets(String companyId) async {
    final response = await dio.get('$url/companies/$companyId/assets');
    if (response.data != null && response.statusCode == 200) {
      return response.data as List<dynamic>;
    } else {
      throw NetworkException();
    }
  }
}
