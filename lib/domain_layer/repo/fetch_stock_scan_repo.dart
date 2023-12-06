import 'package:dartz/dartz.dart';

abstract class FetchStockScanRepo {
  Future<Either<dynamic, dynamic>> fetchStockScan();
}
