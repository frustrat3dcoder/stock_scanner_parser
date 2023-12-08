import 'package:dartz/dartz.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';

class FetchStockScanUseCase {
  final FetchStockScanRepo stockScanRepo;
  FetchStockScanUseCase({
    required this.stockScanRepo,
  });

  Future<Either<Failure, List<StockScanEntity>>> fetchStockScan() async {
    return await stockScanRepo.fetchStockScan();
  }
}
