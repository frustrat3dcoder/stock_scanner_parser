part of 'fetch_stock_data_bloc.dart';

sealed class FetchStockDataEvent extends Equatable {
  const FetchStockDataEvent();

  @override
  List<Object> get props => [];
}

class FetchStockScanData extends FetchStockDataEvent {}
