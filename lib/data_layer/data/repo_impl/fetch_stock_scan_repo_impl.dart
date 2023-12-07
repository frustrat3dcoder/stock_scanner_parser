import 'package:dartz/dartz.dart';
import 'package:stock_scan_parser/data_layer/data_layer.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';

class FetchStockScanRepoImpl implements FetchStockScanRepo {
  final FetchStockDataRemote fetchStockDataSource;

  FetchStockScanRepoImpl({required this.fetchStockDataSource});

  @override
  Future<Either<Failure, List<StockScanEntity>>> fetchStockScan() async {
    try {
      final result = await fetchStockDataSource.fetchStockScan();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
