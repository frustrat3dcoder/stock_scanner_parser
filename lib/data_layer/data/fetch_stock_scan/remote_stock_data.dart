import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_scan_parser/data_layer/data_layer.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';
import 'package:stock_scan_parser/utilities/utilities.dart';

abstract class FetchStockDataRemote {
  Future<List<StockScanEntity>> fetchStockScan();
}

class FetchStockDataRemoteSource extends FetchStockDataRemote {
  final http.Client _client;

  FetchStockDataRemoteSource({required http.Client client}) : _client = client;

  @override
  Future<List<StockScanEntity>> fetchStockScan() async {
    final response = await _client.get(
      Uri.parse(ApiConstants.fetchStockScanUrl),
      headers: {
        'accept': 'application/json ',
      },
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      List<dynamic> decodedData = jsonDecode(utf8.decode(response.bodyBytes));
// print(responseBody);
      final List<StockScanEntity> stockScanEntityList = [];
      decodedData.forEach((e) => stockScanEntityList
          .add(StockScanEntity.fromJson(e as Map<String, dynamic>)));

      return stockScanEntityList;
    }
  }
}
