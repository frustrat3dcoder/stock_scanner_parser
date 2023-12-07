import 'package:flutter/material.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';
import 'package:stock_scan_parser/utilities/utilities.dart';

class StockScanTile extends StatelessWidget {
  const StockScanTile({
    super.key,
    required this.stockEntity,
  });

  final StockScanEntity stockEntity;

  void goToDetail(BuildContext context) {
    Navigator.of(context).pushNamed(RoutesName.stockDetailTile,
        arguments: {'stockScanEntity': stockEntity});
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => goToDetail(context),
      title: Text(
        stockEntity.name!,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
            decorationColor: Colors.white, // Optional: set the underline color

            fontSize: 18.0),
      ),
      subtitle: Text(
        stockEntity.tag!,
        style: TextStyle(
            decoration: TextDecoration.underline,
            color: stockEntity.color!.stringToColor(),
            fontWeight: FontWeight.w700,
            decorationColor: Colors.white,
            fontSize: 13.0),
      ),
    );
  }
}
