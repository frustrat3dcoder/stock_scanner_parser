import 'package:dartz/dartz.dart';
import 'package:stock_scan_parser/data_layer/data_layer.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';

class FetchStockScanRepoImpl extends FetchStockScanRepo {
  final FetchStockDataRemote _fetchStockDataSource;

  FetchStockScanRepoImpl({required FetchStockDataRemote fetchStockDataSource})
      : _fetchStockDataSource = fetchStockDataSource;

  @override
  Future<Either<Failure, List<StockScanEntity>>> fetchStockScan() async {
    try {
      final result = await _fetchStockDataSource.fetchStockScan();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
