import 'package:dartz/dartz.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';

abstract class FetchStockScanRepo {
  Future<Either<Failure, List<StockScanEntity>>> fetchStockScan();
}
