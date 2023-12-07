import 'package:dartz/dartz.dart';
import 'package:stock_scan_parser/data_layer/data_layer.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'fetch_stock_scan_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchStockDataRemoteSource>()])
void main() {
  group('FetchStockScanRepoImpl', () {
    group('should retrun left with', () {
      test('a ServerFailure when a ServerException occurs', () async {
        final mockAdviceRemoteDatasource = MockFetchStockDataRemoteSource();
        final fetchStockScanRepoImplUnderTest = FetchStockScanRepoImpl(
            fetchStockDataSource: mockAdviceRemoteDatasource);

        when(mockAdviceRemoteDatasource.fetchStockScan())
            .thenThrow(ServerException());

        final result = await fetchStockScanRepoImplUnderTest.fetchStockScan();
        final expectedFailure =
            Left<Failure, List<StockScanEntity>>(ServerFailure());

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, equals(expectedFailure));
      });

      test('a GeneralFailure on all other Exceptions', () async {
        final mockAdviceRemoteDatasource = MockFetchStockDataRemoteSource();
        final fetchStockScanRepoImplUnderTest = FetchStockScanRepoImpl(
            fetchStockDataSource: mockAdviceRemoteDatasource);

        when(mockAdviceRemoteDatasource.fetchStockScan())
            .thenThrow(ServerException());

        final result = await fetchStockScanRepoImplUnderTest.fetchStockScan();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, List<StockScanEntity>>(ServerFailure()));
      });
    });
  });
}
