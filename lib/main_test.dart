import 'package:assets_manager/data/remote/my_rds.dart';
import 'package:assets_manager/data/repository/my_repository.dart';
import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  final myRDS = MyRDS(
    url: "https://fake-api.tractian.com",
    dio: dio,
  );
  final myRepo = MyRepository(myRDS: myRDS);
  print("Processing request");
  final response = await myRepo.getLocations("662fd0fab3fd5656edb39af5");
  print(response);
}
