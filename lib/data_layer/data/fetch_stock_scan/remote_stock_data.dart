import 'package:http/http.dart' as http;

abstract class FetchStockDataRemote {
  Future<dynamic> fetchStockScan();
}

class FetchStockDataRemoteSource extends FetchStockDataRemote {
  final http.Client _client;

  FetchStockDataRemoteSource({required http.Client client}) : _client = client;

  @override
  Future<dynamic> fetchStockScan() async {
    try {
      final result = await _client.get(Uri.parse(''), headers: {});
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
