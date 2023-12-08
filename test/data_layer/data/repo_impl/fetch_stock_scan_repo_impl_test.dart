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
    group('should return List<StockScanEntity>', () {
      test('when FetchStockDataRemoteSource returns a List<StockScanEntity>',
          () async {
        final mockStockScanDataImpl = MockFetchStockDataRemoteSource();
        final fethcStockUseCaseUnderTest =
            FetchStockScanRepoImpl(fetchStockDataSource: mockStockScanDataImpl);
        final expectedResult = [
          const StockScanEntity(
            color: 'green',
            id: 1,
            name: 'Top gainers',
            tag: 'Intraday Bullish',
            criteria: [
              CriteriaEntity(
                  type: 'plain_text',
                  text: 'Sort - %price change in descending order')
            ],
          )
        ];
        when(mockStockScanDataImpl.fetchStockScan())
            .thenAnswer((realInvocation) => Future.value(expectedResult));

        final result = await fethcStockUseCaseUnderTest.fetchStockScan();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(result, Right<Failure, List<StockScanEntity>>(expectedResult));
        verify(mockStockScanDataImpl.fetchStockScan()).called(
            1); // when you want to check if a method was not call use verifyNever(mock.methodCall) instead .called(0)
        verifyNoMoreInteractions(mockStockScanDataImpl);
      });
    });

    group('should retrun left with', () {
      test('a ServerFailure when a ServerException occurs', () async {
        final mockFetchStockScanRemoteDataSource =
            MockFetchStockDataRemoteSource();
        final fetchStockScanRepoImplUnderTest = FetchStockScanRepoImpl(
            fetchStockDataSource: mockFetchStockScanRemoteDataSource);

        when(mockFetchStockScanRemoteDataSource.fetchStockScan())
            .thenThrow(ServerException());

        final result = await fetchStockScanRepoImplUnderTest.fetchStockScan();
        final expectedFailure =
            Left<Failure, List<StockScanEntity>>(ServerFailure());

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, equals(expectedFailure));
      });

      test('a GeneralFailure on all other Exceptions', () async {
        final mockFetchStockScanRemoteDataSource =
            MockFetchStockDataRemoteSource();
        final fetchStockScanRepoImplUnderTest = FetchStockScanRepoImpl(
            fetchStockDataSource: mockFetchStockScanRemoteDataSource);

        when(mockFetchStockScanRemoteDataSource.fetchStockScan())
            .thenThrow(ServerException());

        final result = await fetchStockScanRepoImplUnderTest.fetchStockScan();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, List<StockScanEntity>>(ServerFailure()));
      });
    });
  });
}
