import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';

part 'fetch_stock_data_event.dart';
part 'fetch_stock_data_state.dart';

class FetchStockDataBloc
    extends Bloc<FetchStockDataEvent, FetchStockDataState> {
  final FetchStockScanUseCase fetchStockScanUseCase;
  FetchStockDataBloc({required this.fetchStockScanUseCase})
      : super(FetchStockDataInitial()) {
    on<FetchStockDataEvent>((event, emit) async {
      final result = await fetchStockScanUseCase.fetchStockScan();

      print("result is $result");
    });
  }
}
