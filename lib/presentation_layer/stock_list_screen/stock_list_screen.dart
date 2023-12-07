import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_scan_parser/injector.dart';
import 'package:stock_scan_parser/presentation_layer/bloc/fetch_stock_data_bloc.dart';
import 'package:stock_scan_parser/presentation_layer/widgets/custom_seperator.dart';
import 'package:stock_scan_parser/presentation_layer/widgets/stock_list_tile.dart';

class StockListPageWrapperProvider extends StatelessWidget {
  const StockListPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchStockDataBloc(fetchStockScanUseCase: sl()),
      child: const StockListScreen(),
    );
  }
}

class StockListScreen extends StatelessWidget {
  const StockListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FetchStockDataBloc>(context, listen: false)
        .add(FetchStockScanData());
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Expanded(child: Center(
                child: BlocBuilder<FetchStockDataBloc, FetchStockDataState>(
              builder: (context, state) {
                if (state is FetchStockDataInitial) {
                  return const CircularProgressIndicator(
                    color: Colors.amber,
                  );
                } else if (state is FetchStockDataLoaded) {
                  return ListView.separated(
                    itemCount: state.stockEntityList.length,
                    itemBuilder: (context, index) => StockScanTile(
                        stockEntity: state.stockEntityList[index]),
                    separatorBuilder: (context, index) => const DottedDivider(),
                  );
                } else if (state is FetchStockDataFailure) {
                  return Text(
                    state.errorMessage,
                    // style: themeData.textTheme.headline1,
                  );
                }
                return const SizedBox();
              },
            ))),
          ],
        ),
      )),
    );
  }
}
