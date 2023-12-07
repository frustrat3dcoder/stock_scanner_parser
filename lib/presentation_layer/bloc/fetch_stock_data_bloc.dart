import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';
import 'package:stock_scan_parser/utilities/utilities.dart';

part 'fetch_stock_data_event.dart';
part 'fetch_stock_data_state.dart';

class FetchStockDataBloc
    extends Bloc<FetchStockDataEvent, FetchStockDataState> {
  final FetchStockScanUseCase fetchStockScanUseCase;
  FetchStockDataBloc({required this.fetchStockScanUseCase})
      : super(FetchStockDataInitial()) {
    on<FetchStockScanData>((event, emit) async {
      emit(FetchStockDataInitial());
      final stockDataOrFailure = await fetchStockScanUseCase.fetchStockScan();

      stockDataOrFailure.fold(
        (failure) => emit(
            FetchStockDataFailure(errorMessage: failure.mapFailureToMessage())),
        (stockData) => emit(FetchStockDataLoaded(stockEntityList: stockData)),
      );
    });
  }
}
