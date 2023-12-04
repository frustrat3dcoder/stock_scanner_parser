import 'package:http/http.dart' as http;

class FetchStockDataSource {
  final http.Client _client;

  FetchStockDataSource({required http.Client client}) : _client = client;

  Future<dynamic> fetchStockScan() async {
    try {
      final result = await _client.get(Uri.parse(''), headers: {});
      return "";
    } catch (e) {
      rethrow;
    }
  }
}
