
import 'package:assets_manager/data/remote/my_rds.dart';

class MyRepository {
  MyRepository({
    required MyRDS myRDS,
}) : _myRDS = myRDS;

  final MyRDS _myRDS;
}