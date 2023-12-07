import 'package:stock_scan_parser/data_layer/data/data.dart';
import 'package:stock_scan_parser/data_layer/data_layer.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';
// import 'package:flutter_test/flutter_test.dart';

import 'remote_stock_data_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('FetchStockDataRemoteSource', () {
    group('should return <StockScanEntity>', () {
      test('when Client response was 200 and has valid data', () async {
        final client = MockClient();
        const responseBody =
            '[{"id": 1, "name": "Top gainers", "tag":"Intraday Bullish", "color": "green", "criteria": [{ "type": "plain_text", "text": "Sort - %price change in descending order" }]}]';
        final stockScanRemoteRepoUnderTest =
            FetchStockDataRemoteSource(client: client);

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(client.get(
          Uri.parse('http://coding-assignment.bombayrunning.com/data.json'),
          headers: {
            'accept': 'application/json',
          },
        )).thenAnswer((_) => Future.value(Response(responseBody, 200)));
        final result = await stockScanRemoteRepoUnderTest.fetchStockScan();
        expect(result, [
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
        ]);
      });
    });

    group('should throw', () {
      test('a ServerException when Client response was not 200', () {
        final mockClient = MockClient();
        final stockScanRemoteRepoUnderTest =
            FetchStockDataRemoteSource(client: mockClient);

        when(mockClient.get(
          Uri.parse('http://coding-assignment.bombayrunning.com/data.json'),
          headers: {
            'accept': 'application/json',
          },
        )).thenAnswer((realInvocation) => Future.value(Response('', 201)));

        expect(() => stockScanRemoteRepoUnderTest.fetchStockScan(),
            throwsA(isA<ServerException>()));
      });

      test('a Type Error when Client response was 200 and has no valid data',
          () {
        final mockClient = MockClient();
        final stockScanRemoteRepoUnderTest =
            FetchStockDataRemoteSource(client: mockClient);
        const responseBody =
            '[{"id": "1", "name": "Top gainers", "tag":"Intraday Bullish", "color": "green", "criteria": [{ "type": "plain_text", "text": "Sort - %price change in descending order" }]}]';

        when(mockClient.get(
          Uri.parse('http://coding-assignment.bombayrunning.com/data.json'),
          headers: {
            'accept': 'application/json',
          },
        )).thenAnswer(
            (realInvocation) => Future.value(Response(responseBody, 200)));

        expect(() => stockScanRemoteRepoUnderTest.fetchStockScan(),
            throwsA(isA<TypeError>()));
      });
    });
  });
}
