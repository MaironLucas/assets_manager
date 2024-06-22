import 'package:dio/dio.dart';

class MyRDS {
  MyRDS({
    required this.url,
    required this.dio,
  });

  final String url;
  final Dio dio;

  Future<void> getCompanies() async {
    final response = await dio.get('$url/companies');
  }
}
