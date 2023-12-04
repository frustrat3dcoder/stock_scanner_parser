import 'package:dartz/dartz.dart';

abstract class FetchStockScan {
  Future<Either<dynamic, dynamic>> fetchStockScan();
}
