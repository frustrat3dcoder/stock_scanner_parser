part of 'fetch_stock_data_bloc.dart';

sealed class FetchStockDataState extends Equatable {
  const FetchStockDataState();

  @override
  List<Object> get props => [];
}

final class FetchStockDataInitial extends FetchStockDataState {}

final class FetchStockDataLoaded extends FetchStockDataState {
  final List<StockScanEntity> stockEntityList;
  const FetchStockDataLoaded({required this.stockEntityList});

  @override
  List<Object> get props => [stockEntityList];
}

final class FetchStockDataFailure extends FetchStockDataState {
  final String errorMessage;
  const FetchStockDataFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
