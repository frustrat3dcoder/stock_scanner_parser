// import 'package:flutter/foundation.dart';
// import 'package:hive/hive.dart';

// abstract class FetchStockDataLocal {
//   Future<dynamic> fetchStockScan();
// }

// class HiveFetchStockScanLocalDataSource extends FetchStockDataLocal {
//   late BoxCollection stockScanCollection;

//   bool isInitialized = false;

//   Future<void> init() async {
//     if (!isInitialized) {
//       stockScanCollection = await BoxCollection.open(
//         'stockScan',
//         {},
//         path: './',
//       );
//       isInitialized = true;
//     } else {
//       debugPrint('Hive was already initialized!');
//     }
//   }

//   Future<CollectionBox<List<Map>>> _openStockScanBox() async {
//     return stockScanCollection.openBox<List<Map>>('stockScan');
//   }

//   @override
//   Future<dynamic> fetchStockScan() async {
//     throw UnimplementedError();
//   }
// }
