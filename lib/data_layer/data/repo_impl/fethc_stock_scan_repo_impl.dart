import 'package:dartz/dartz.dart';
import 'package:stock_scan_parser/data_layer/data/data.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';

class FetchStockScanRepoImpl extends FetchStockScanRepo {
  final FetchStockDataRemote _fetchStockDataSource;

  FetchStockScanRepoImpl({required FetchStockDataRemote fetchStockDataSource})
      : _fetchStockDataSource = fetchStockDataSource;

  @override
  Future<Either<dynamic, dynamic>> fetchStockScan() async {
    try {
      final result = await _fetchStockDataSource.fetchStockScan();
      return left(result);
    } catch (e) {
      throw '';
    }
  }
}
