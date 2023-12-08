import 'package:dartz/dartz.dart';
import 'package:stock_scan_parser/data_layer/data_layer.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'fetch_stock_scan_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchStockScanRepoImpl>()])
void main() {
  group('FetchStockScanUseCase', () {
    group('should return List<StockScanEntity>', () {
      test('when AdviceRepoImpl returns a List<StockScanEntity>', () async {
        final mockStockScanRepImpl = MockFetchStockScanRepoImpl();
        final fethcStockUseCaseUnderTest =
            FetchStockScanUseCase(stockScanRepo: mockStockScanRepImpl);
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
        when(mockStockScanRepImpl.fetchStockScan()).thenAnswer(
            (realInvocation) => Future.value(Right(expectedResult)));

        final result = await fethcStockUseCaseUnderTest.fetchStockScan();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(result, Right<Failure, List<StockScanEntity>>(expectedResult));
        verify(mockStockScanRepImpl.fetchStockScan()).called(
            1); // when you want to check if a method was not call use verifyNever(mock.methodCall) instead .called(0)
        verifyNoMoreInteractions(mockStockScanRepImpl);
      });
    });

    group('should return left with', () {
      test('a ServerFailure', () async {
        final mockStockScanRepImpl = MockFetchStockScanRepoImpl();
        final fethcStockUseCaseUnderTest =
            FetchStockScanUseCase(stockScanRepo: mockStockScanRepImpl);
        when(mockStockScanRepImpl.fetchStockScan()).thenAnswer(
            (realInvocation) => Future.value(Left(ServerFailure())));

        final result = await fethcStockUseCaseUnderTest.fetchStockScan();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, List<StockScanEntity>>(ServerFailure()));
        verify(mockStockScanRepImpl.fetchStockScan()).called(1);
        verifyNoMoreInteractions(mockStockScanRepImpl);
      });

      test('a GeneralFailure', () async {
        // arrange
        final mockStockScanRepImpl = MockFetchStockScanRepoImpl();
        final fethcStockUseCaseUnderTest =
            FetchStockScanUseCase(stockScanRepo: mockStockScanRepImpl);
        when(mockStockScanRepImpl.fetchStockScan()).thenAnswer(
            (realInvocation) => Future.value(Left(GeneralFailure())));

        // act
        final result = await fethcStockUseCaseUnderTest.fetchStockScan();

        // assert
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, List<StockScanEntity>>(GeneralFailure()));
        verify(mockStockScanRepImpl.fetchStockScan()).called(1);
        verifyNoMoreInteractions(mockStockScanRepImpl);
      });
    });
  });
}
