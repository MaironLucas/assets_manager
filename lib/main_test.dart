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
  final response = await myRepo.getAssetsTree("662fd100f990557384756e58");
  print(response);
}
