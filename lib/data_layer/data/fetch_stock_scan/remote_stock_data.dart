import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_scan_parser/data_layer/data_layer.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';

abstract class FetchStockDataRemote {
  Future<List<StockScanEntity>> fetchStockScan();
}

class FetchStockDataRemoteSource implements FetchStockDataRemote {
  final http.Client client;

  FetchStockDataRemoteSource({required this.client});

  @override
  Future<List<StockScanEntity>> fetchStockScan() async {
    final response = await client.get(
      Uri.parse('http://coding-assignment.bombayrunning.com/data.json'),
      headers: {
        'accept': 'application/json',
      },
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      List<dynamic> decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      final List<StockScanEntity> stockScanEntityList = [];
      for (var e in decodedData) {
        stockScanEntityList
            .add(StockScanEntity.fromJson(e as Map<String, dynamic>));
      }

      return stockScanEntityList;
    }
  }

  // final response = await client.get(
  //   Uri.parse('http://coding-assignment.bombayrunning.com/data.json'),
  //   headers: {
  //     'accept': 'application/json ',
  //   },
  // );
  //  }
}
