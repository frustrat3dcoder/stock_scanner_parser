abstract class FetchStockDataLocal {
  Future<dynamic> fetchStockScan();
}

class FetchStockLocalDataSource extends FetchStockDataLocal {
  @override
  Future<dynamic> fetchStockScan() async {
    throw UnimplementedError();
  }
}
