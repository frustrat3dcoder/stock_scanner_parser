import 'package:get_it/get_it.dart';
import 'package:stock_scan_parser/data_layer/data/data.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';
import 'package:stock_scan_parser/presentation_layer/bloc/fetch_stock_data_bloc.dart';
import 'package:http/http.dart' as http;

/// sl = service locator
final sl = GetIt.I;

Future<void> init() async {
  // ! data layer
  // sl.registerFactory<FetchStockDataLocal>(
  //     () => HiveFetchStockScanLocalDataSource());
  sl.registerFactory<FetchStockDataRemote>(
      () => FetchStockDataRemoteSource(client: sl()));

  // ? domain layer
  sl.registerFactory<FetchStockScanUseCase>(
      () => FetchStockScanUseCase(stockScanRepo: sl()));
  sl.registerFactory<FetchStockScanRepo>(() =>
      FetchStockScanRepoImpl(fetchStockDataSource: sl<FetchStockDataRemote>()));

  // * application layer
  sl.registerFactory<FetchStockDataBloc>(() =>
      FetchStockDataBloc(fetchStockScanUseCase: sl<FetchStockScanUseCase>()));

  sl.registerFactory<http.Client>(() => http.Client());
}
