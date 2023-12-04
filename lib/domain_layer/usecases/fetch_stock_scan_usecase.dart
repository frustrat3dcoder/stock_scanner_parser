import 'package:dartz/dartz.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';

class FetchStockScanUseCase {
  final FetchStockScanRepo _stockScanRepo;
  FetchStockScanUseCase({
    required FetchStockScanRepo stockScanRepo,
  }) : _stockScanRepo = stockScanRepo;

  Future<Either<dynamic, dynamic>> fetchStockScan() async {
    final result = await _stockScanRepo.fetchStockScan();

    return result;
  }
}
