part of 'fetch_stock_data_bloc.dart';

sealed class FetchStockDataState extends Equatable {
  const FetchStockDataState();
  
  @override
  List<Object> get props => [];
}

final class FetchStockDataInitial extends FetchStockDataState {}
